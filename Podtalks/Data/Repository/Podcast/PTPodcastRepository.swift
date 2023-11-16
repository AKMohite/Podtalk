//
//  PTPodcastRepository.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 26/10/23.
//

import Foundation

final class PTPodcastRepository: PodcastRepository {
    
    private let api: HttpClient
    private let genreRepo: GenreRepository
    
    init(api: HttpClient = PodTalkHttpClient.shared, genreRepo: GenreRepository = PTGenreRepository()) {
        self.api = api
        self.genreRepo = genreRepo
    }
    
    func getBestPodcasts() async throws -> [PTPodcast] {
        let paramters = ["sort" : "listen_score"]
        return try await getPodcasts(with: paramters)
    }
    
    func getRecentAddedPodcasts() async throws -> [PTPodcast] {
        let paramters = ["sort" : "recent_added_first"]
        return try await getPodcasts(with: paramters)
    }
    
    func fetchDetails(for id: String) async throws -> PTPodcastDetails {
        let request = PodtalkHttpRequest(endpoint: .podcasts, pathSegments: [id])
        let dto = try await api.execute(request: request, expecting: PodcastDetailDTO.self)
        let episodes = dto.episodes.compactMap { episode in
            PTEpisode(id: episode.id, title: episode.title, description: episode.description, audio: URL(string: episode.audio), image: URL(string: episode.image), thumbnail: URL(string: episode.thumbnail), audioDuration: episode.audio_length_sec, publishedDate: episode.pub_date_ms)
        }
        let genreIds: [Int16] = dto.genre_ids.compactMap { id in
            Int16(id)
        }
        let genres: [TalkGenre] = try await genreRepo.getGenre(by: genreIds)
        let podcastInfo = PTPodcastInfo(id: dto.id, title: dto.title, description: dto.description, thumbnail: URL(string: dto.thumbnail), image: URL(string: dto.image), genres: genres, listenScore: dto.listen_score, totalEpisodes: dto.total_episodes, isExplicit: dto.explicit_content, updateFrequency: dto.update_frequency_hours)
        let details = PTPodcastDetails(info: podcastInfo, episodes: episodes)
        return details
    }
    
    func getCuratedPodcasts() async throws -> [CuratedPodcast] {
        let dto = try await api.execute(request: .init(endpoint: .curated_podcasts), expecting: CuratedPodcastsDTO.self)
        let curatedList: [CuratedPodcast] = dto.curated_lists.map { curatedPodcasts in
            let podcasts = curatedPodcasts.podcasts.map { podcast in
                PTPodcast(id: podcast.id, name: podcast.title, description: podcast.description ?? "NA", numberOfEpisodes: String(podcast.total_episodes ?? 0), image: URL(string: podcast.image), thumbnail: URL(string: podcast.thumbnail), publishedBy: podcast.publisher)
            }
            return CuratedPodcast(id: curatedPodcasts.id, title: curatedPodcasts.title, total: curatedPodcasts.total, description: curatedPodcasts.description, podcasts: podcasts)
        }
        return curatedList
    }
    
    func searchPodcasts(with query: String) async throws -> [PTPodcast] {
        let queryParams = [
            "q": query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            "type": "podcast"
        ]
//        let results = try await api.execute(request: .init(endpoint: .search, queryParameters: queryParams), expecting: SearchPodcastDTO.self)
        let results = mockSearchPodcasts()
        let podcasts = results.results.compactMap { podcast in
            PTPodcast(id: podcast.id, name: podcast.title_original, description: podcast.description_original, numberOfEpisodes: String(podcast.total_episodes), image: URL(string: podcast.image), thumbnail: URL(string: podcast.thumbnail), publishedBy: podcast.publisher_original)
        }
        return podcasts
    }
    
    func searchEpisodes(with query: String) async throws -> [PTEpisode] {
        let queryParams = [
            "q": query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            "type": "episode"
        ]
//        let results = try await api.execute(request: .init(endpoint: .search, queryParameters: queryParams), expecting: SearchEpisodeDTO.self)
        let results = mockSearchEpisodes()
        let episodes = results.results.compactMap { episode in
            PTEpisode(id: episode.id, title: episode.title_original, description: episode.description_original, audio: URL(string: episode.audio), image: URL(string: episode.image), thumbnail: URL(string: episode.thumbnail), audioDuration: episode.audio_length_sec, publishedDate: episode.pub_date_ms)
        }
        return episodes
    }
    
    fileprivate func getPodcasts(with paramters: [String : String]) async throws -> [PTPodcast] {
        let dto = try await api.execute(request: .init(endpoint: .best_podcasts, queryParameters: paramters), expecting: BestPodcastsDTO.self)
        let podcasts = dto.podcasts.compactMap { podcast in
            PTPodcast(id: podcast.id, name: podcast.title, description: podcast.description ?? "NA", numberOfEpisodes: String(podcast.total_episodes ?? 0), image: URL(string: podcast.image), thumbnail: URL(string: podcast.thumbnail), publishedBy: podcast.publisher)
        }
        return podcasts
    }
}

// MARK: - Mock data
extension PTPodcastRepository {
    fileprivate func createPodcast(for id: String) -> SearchPodcastResultDTO {
        return SearchPodcastResultDTO(id: id, title_original: "Android Central Podcast", description_original: "The Android podcast for everyone. A weekly show about Android, Google, and the best of mobile technology.", publisher_original: "Android Central", image: "https://production.listennotes.com/podcasts/android-central-podcast-android-central-tlAQIWbuzma-se3tXLNjgMS.300x300.jpg", thumbnail: "https://production.listennotes.com/podcasts/android-central-podcast-android-central-tlAQIWbuzma-se3tXLNjgMS.300x300.jpg", genre_ids: [130, 127], total_episodes: 145)
    }
    
    fileprivate func createEpisode(for id: String) -> SearchEpisodeResultDTO {
        return SearchEpisodeResultDTO(id: id, audio: "https://www.listennotes.com/e/p/0b267aeb3d704793afbe50d98aff8867/", audio_length_sec: 152, title_original: "Welcome, Android Faithful", description_original: "Android Faithful is your weekly source for Android news, hardware, apps and more. Join Huyen Tue Dao and Ron Richards, along with a host of Android friends and experts as they keep you up to date every week on everything important to the world of Android From phones and foldables, to tablets and TVs and more. We are the Android Faithful.<br /><hr /><p style=\"color: grey; font-size: 0.75em;\"> Hosted on Acast. See <a href=\"https://acast.com/privacy\" rel=\"noopener noreferrer\" style=\"color: grey;\" target=\"_blank\">acast.com/privacy</a> for more information.</p>", image: "https://production.listennotes.com/podcasts/android-faithful-XQEvH7Ap42T-8wKj0WTNkZn.300x300.jpg", thumbnail: "https://production.listennotes.com/podcasts/android-faithful-XQEvH7Ap42T-8wKj0WTNkZn.300x300.jpg", pub_date_ms: Date(), explicit_content: false)
    }
    
    fileprivate func mockSearchPodcasts() -> SearchPodcastDTO {
        return SearchPodcastDTO(count: 10, next_offset: 10, total: 3654, results: [
            createPodcast(for: "9405da6b16c94d6f8c586a3595bcb575"),
            createPodcast(for: "9405da6b16c94d6f8c586a3595bcb575"),
            createPodcast(for: "9405da6b16c94d6f8c586a3595bcb575"),
            createPodcast(for: "9405da6b16c94d6f8c586a3595bcb575"),
            createPodcast(for: "9405da6b16c94d6f8c586a3595bcb575"),
            createPodcast(for: "9405da6b16c94d6f8c586a3595bcb575"),
            createPodcast(for: "9405da6b16c94d6f8c586a3595bcb575"),
            createPodcast(for: "9405da6b16c94d6f8c586a3595bcb575"),
            createPodcast(for: "9405da6b16c94d6f8c586a3595bcb575"),
            createPodcast(for: "9405da6b16c94d6f8c586a3595bcb575")
        ])
    }
    
    fileprivate func mockSearchEpisodes() -> SearchEpisodeDTO {
        return SearchEpisodeDTO(count: 10, next_offset: 10, total: 10000, results: [
            createEpisode(for: "0b267aeb3d704793afbe50d98aff8867"),
            createEpisode(for: "0b267aeb3d704793afbe50d98aff8867"),
            createEpisode(for: "0b267aeb3d704793afbe50d98aff8867"),
            createEpisode(for: "0b267aeb3d704793afbe50d98aff8867"),
            createEpisode(for: "0b267aeb3d704793afbe50d98aff8867"),
            createEpisode(for: "0b267aeb3d704793afbe50d98aff8867"),
            createEpisode(for: "0b267aeb3d704793afbe50d98aff8867"),
            createEpisode(for: "0b267aeb3d704793afbe50d98aff8867"),
            createEpisode(for: "0b267aeb3d704793afbe50d98aff8867"),
            createEpisode(for: "0b267aeb3d704793afbe50d98aff8867")
        ])
    }
}

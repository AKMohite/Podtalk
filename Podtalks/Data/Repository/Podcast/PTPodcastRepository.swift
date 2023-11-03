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
    
    fileprivate func getPodcasts(with paramters: [String : String]) async throws -> [PTPodcast] {
        let dto = try await api.execute(request: .init(endpoint: .best_podcasts, queryParameters: paramters), expecting: BestPodcastsDTO.self)
        let podcasts = dto.podcasts.compactMap { podcast in
            PTPodcast(id: podcast.id, name: podcast.title, description: podcast.description ?? "NA", numberOfEpisodes: String(podcast.total_episodes ?? 0), image: URL(string: podcast.image), thumbnail: URL(string: podcast.thumbnail), publishedBy: podcast.publisher)
        }
        return podcasts
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
        let details = PTPodcastDetails(id: dto.id, title: dto.title, description: dto.description, thumbnail: URL(string: dto.thumbnail), image: URL(string: dto.image), genres: genres, listenScore: dto.listen_score, totalEpisodes: dto.total_episodes, isExplicit: dto.explicit_content, updateFrequency: dto.update_frequency_hours, episodes: episodes)
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
}

//
//  PTEpisodeRepository.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 14/11/23.
//

import Foundation

final class PTEpisodeRepository: EpisodeRepository {
    
    private let api: HttpClient
    
    init(api: HttpClient = PodTalkHttpClient()) {
        self.api = api
    }
    
    func fetchDetails(with id: String) async throws -> PTEpisodeDetail {
        let details = try await api.execute(request: .init(endpoint: .episodes, pathSegments: [id]), expecting: EpisodeDetailDTO.self)
        let podcast = details.podcast
        let episodeDetail = PTEpisodeDetail(episode: PTEpisode(id: details.id, title: details.title, description: details.description, audio: URL(string: details.audio), image: URL(string: details.image), thumbnail: URL(string: details.thumbnail), audioDuration: details.audio_length_sec, publishedDate: details.pub_date_ms), podcast: PTPodcast(id: podcast.id, name: podcast.title, description: podcast.description ?? "NA", numberOfEpisodes: String(podcast.total_episodes ?? 0) , image: URL(string: podcast.image), thumbnail: URL(string: podcast.thumbnail), publishedBy: podcast.publisher))
        return episodeDetail
    }
    
}

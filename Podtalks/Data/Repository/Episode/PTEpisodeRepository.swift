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
    
    func fetchDetails(with id: String) async throws -> PTEpisode {
        let details = try await api.execute(request: .init(endpoint: .episodes, pathSegments: [id]), expecting: EpisodeDTO.self)
        let episodeDetail = PTEpisode(id: details.id, title: details.title, description: details.description, audio: URL(string: details.audio), image: URL(string: details.image), thumbnail: URL(string: details.thumbnail), audioDuration: details.audio_length_sec, publishedDate: details.pub_date_ms)
        return episodeDetail
    }
    
}

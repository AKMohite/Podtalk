//
//  PTPodcastRepository.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 26/10/23.
//

import Foundation

final class PTPodcastRepository: PodcastRepository {
    
    private let api: HttpClient
    
    init(api: HttpClient = PodTalkHttpClient.shared) {
        self.api = api
    }
    
    func getBestPodcasts() async throws -> [PTPodcast] {
        let dto = try await api.execute(request: .init(endpoint: .best_podcasts), expecting: BestPodcastsDTO.self)
        let podcasts = dto.podcasts.compactMap { podcast in
            PTPodcast(id: podcast.id, name: podcast.title, description: podcast.description, image: URL(string: podcast.image))
        }
        return podcasts
    }
}

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
        let paramters = ["sort" : "listen_score"]
        let dto = try await api.execute(request: .init(endpoint: .best_podcasts, queryParameters: paramters), expecting: BestPodcastsDTO.self)
        let podcasts = dto.podcasts.compactMap { podcast in
            PTPodcast(id: podcast.id, name: podcast.title, description: podcast.description ?? "NA", image: URL(string: podcast.image))
        }
        return podcasts
    }
    
    func getCuratedPodcasts() async throws -> [CuratedPodcast] {
        let dto = try await api.execute(request: .init(endpoint: .curated_podcasts), expecting: CuratedPodcastsDTO.self)
        let curatedList: [CuratedPodcast] = dto.curated_lists.map { curatedPodcasts in
            let podcasts = curatedPodcasts.podcasts.map { podcast in
                PTPodcast(id: podcast.id, name: podcast.title, description: podcast.description ?? "NA", image: URL(string: podcast.image))
            }
            return CuratedPodcast(id: curatedPodcasts.id, title: curatedPodcasts.title, total: curatedPodcasts.total, description: curatedPodcasts.description, podcasts: podcasts)
        }
        return curatedList
    }
}
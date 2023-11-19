//
//  PodcastRepository.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 26/10/23.
//

import Foundation

protocol PodcastRepository {
    func getBestPodcasts(page: Int) async throws -> [PTPodcast]
    func getRecentAddedPodcasts(page: Int) async throws -> [PTPodcast]
    func fetchDetails(for id: String) async throws -> PTPodcastDetails
    func getCuratedPodcasts(page: Int) async throws -> [CuratedPodcast]
    func searchPodcasts(with query: String, page: Int) async throws -> [PTPodcast]
    func searchEpisodes(with query: String, page: Int) async throws -> [PTEpisode]
}

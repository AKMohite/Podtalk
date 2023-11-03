//
//  PodcastRepository.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 26/10/23.
//

import Foundation

protocol PodcastRepository {
    func getBestPodcasts() async throws -> [PTPodcast]
    func getRecentAddedPodcasts() async throws -> [PTPodcast]
    func fetchDetails(for id: String) async throws -> PTPodcastDetails
    func getCuratedPodcasts() async throws -> [CuratedPodcast]
}

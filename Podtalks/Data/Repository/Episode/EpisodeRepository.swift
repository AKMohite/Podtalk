//
//  EpisodeRepository.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 14/11/23.
//

import Foundation

protocol EpisodeRepository {
    func fetchDetails(with id: String) async throws -> PTEpisode
}

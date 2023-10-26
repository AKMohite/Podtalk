//
//  PodcastDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

struct PodcastDTO: Decodable {
    let id: String
    let type: PodcastType
    let image: String
    let title: String
    let country: String
    let website: String
    let genreIds: [Int]
    let publisher: String
    let thumbnail: String
    let description: String
    let listenScore: String
    let totalEpisodes: Int
    let excplicitContent: Bool
    let lastUpdatedAt: Date
    let earliestUpdatedAt: Date
    let updateFrequencyHours: Int
}


enum PodcastType: Decodable {
    case episodic
    case series
}

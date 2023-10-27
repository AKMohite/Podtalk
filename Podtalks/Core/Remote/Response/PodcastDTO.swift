//
//  PodcastDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

struct PodcastDTO: Decodable {
    let id: String
    let type: String
//    let type: PodcastType
    let image: String
    let thumbnail: String
    let title: String
    let description: String
    let genre_ids: [Int]
    let country: String?
    let website: String?
    let publisher: String?
    let listen_score: Int
    let total_episodes: Int
    let explicit_content: Bool
    let latest_pub_date_ms: Date
    let earliest_pub_date_ms: Date
    let update_frequency_hours: Int
}


enum PodcastType: Decodable {
    case episodic
    case series
}

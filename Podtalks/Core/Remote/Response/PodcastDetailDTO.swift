//
//  PodcastDetailDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 03/11/23.
//

import Foundation

struct PodcastDetailDTO: Decodable {
    let id: String
    let title: String
    let description: String
    let type: String
    let thumbnail: String
    let image: String
    let genre_ids: [Int]
    let listen_score: Int
    let total_episodes: Int
    let explicit_content: Bool
    let latest_episode_id: String
    let latest_pub_date_ms: Date
    let earliest_pub_date_ms: Date
    let next_episode_pub_date: Date
    let update_frequency_hours: Int
    let episodes: [EpisodeDTO]
}

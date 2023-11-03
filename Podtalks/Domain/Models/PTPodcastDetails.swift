//
//  PTPodcastDetails.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 03/11/23.
//

import Foundation

struct PTPodcastDetails {
    let info: PTPodcastInfo
    let episodes: [PTEpisode]
}

struct PTPodcastInfo {
    let id: String
    let title: String
    let description: String
//    let type: String
    let thumbnail: URL?
    let image: URL?
    let genres: [TalkGenre]
    let listenScore: Int
    let totalEpisodes: Int
    let isExplicit: Bool
//    let latest_episode_id: String
//    let latest_pub_date_ms: Date
//    let earliest_pub_date_ms: Date
//    let next_episode_pub_date: Date
    let updateFrequency: Int
}

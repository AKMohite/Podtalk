//
//  SearchPodcastDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 13/11/23.
//

import Foundation

struct SearchPodcastDTO: Decodable {
    let count: Int
    let next_offset: Int
    let total: Int
    let results: [SearchPodcastResultDTO]
}

struct SearchPodcastResultDTO: Decodable {
    let id: String
    let title_original: String
    let description_original: String
    let publisher_original: String
    let image: String
    let thumbnail: String
    let genre_ids: [Int]
    let total_episodes: Int
}

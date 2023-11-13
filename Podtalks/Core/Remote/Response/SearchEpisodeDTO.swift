//
//  SearchEpisodeDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 13/11/23.
//

import Foundation

struct SearchEpisodeDTO: Decodable {
    let count: Int
    let next_offset: Int
    let total: Int
    let results: [SearchEpisodeResultDTO]
}

struct SearchEpisodeResultDTO: Decodable {
    let id: String
    let audio: String
    let audio_length_sec: Int
    let title_original: String
    let description_original: String
    let image: String
    let thumbnail: String
    let pub_date_ms: Date
    let explicit_content: Bool
//    let podcasat: PodcastDTO
}

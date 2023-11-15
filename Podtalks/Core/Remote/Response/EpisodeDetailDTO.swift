//
//  EpisodeDetailDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 15/11/23.
//

import Foundation

struct EpisodeDetailDTO: Decodable {
    let id: String
    let title: String
    let description: String
    let thumbnail: String
    let image: String
    let audio: String
    let audio_length_sec: Int
    let explicit_content: Bool
    let pub_date_ms: Date // published on
    let podcast: PodcastDTO
}

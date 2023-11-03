//
//  EpisodeDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 03/11/23.
//

import Foundation

struct EpisodeDTO: Decodable {
    let id: String
    let title: String
    let description: String
    let thumbnail: String
    let image: String
    let audio: String
    let audio_length_sec: Int
    let explicit_content: Bool
    let pub_date_ms: Date // published on
}

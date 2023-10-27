//
//  BestPodcastsDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

struct BestPodcastsDTO: Decodable {
    let id: Int
    let name: String?
    let total: Int
    let has_next: Bool
    let page_number: Int
    let has_previous: Bool
    let next_page_number: Int?
    let previous_page_number: Int?
    let podcasts: [PodcastDTO]
}

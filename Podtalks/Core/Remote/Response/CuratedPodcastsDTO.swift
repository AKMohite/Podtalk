//
//  CuratedPodcastsDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 27/10/23.
//

import Foundation

internal struct CuratedPodcastsDTO: Decodable {
    let total: Int
    let has_next: Bool
    let page_number: Int
    let has_previous: Bool
    let next_page_number: Int?
    let previous_page_number: Int?
    let curated_lists: [CuratedPodcastDTO]
}

internal struct CuratedPodcastDTO: Decodable {
    let id: String
    let title: String
    let description: String
    let total: Int
    let podcasts: [PodcastDTO]
}

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
    let hasNext: Bool
    let pageNumber: Int
    let hasPrevious: Bool
    let nextPageNumber: Int?
    let previousPageNumber: Int?
    let podcasts: [PodcastDTO]
}

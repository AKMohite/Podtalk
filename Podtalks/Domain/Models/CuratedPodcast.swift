//
//  CuratedPodcast.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 27/10/23.
//

import Foundation

internal struct CuratedPodcast {
    let id: String
    let title: String
    let total: Int
    let description: String
    let podcasts: [PTPodcast]
}

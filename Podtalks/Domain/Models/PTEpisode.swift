//
//  PTEpisode.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 03/11/23.
//

import Foundation

struct PTEpisode {
    let id: String
    let title: String
    let description: String
    let audio: URL?
    let image: URL?
    let thumbnail: URL?
    let audioDuration: Int
    let publishedDate: Date
}

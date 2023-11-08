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
    
    var duration: String {
        let (minutes, seconds) = (audioDuration / 60, (audioDuration % 60))
        return "\(minutes):\(seconds)"
    }
}

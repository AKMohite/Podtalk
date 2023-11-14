//
//  PTSearchResults.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 13/11/23.
//

import Foundation

enum PTSearchResults {
    case podcasts([PTPodcast])
    case episodes([PTEpisode])
    
    var title: String {
        switch self {
            case .podcasts: return "Podcasts"
            case .episodes(let array): return "Episodes"
        }
    }
}

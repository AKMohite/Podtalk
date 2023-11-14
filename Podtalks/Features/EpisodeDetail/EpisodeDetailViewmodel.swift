//
//  EpisodeDetailViewmodel.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 14/11/23.
//

import Foundation

final class EpisodeDetailViewmodel {
    
    private let repo: EpisodeRepository
    
    init(repo: EpisodeRepository = PTEpisodeRepository()) {
        self.repo = repo
    }
    
    func fetchDetails(with episode: PTEpisode) {
        Task {
            do {
                
            } catch {
                
            }
        }
    }
    
}

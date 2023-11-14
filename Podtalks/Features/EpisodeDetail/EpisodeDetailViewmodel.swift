//
//  EpisodeDetailViewmodel.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 14/11/23.
//

import Foundation

protocol EpisodeDetailViewmodelDelegate: AnyObject {
    func loadData(with details: PTEpisode)
    func showError(with message: String?)
}

final class EpisodeDetailViewmodel {
    
    weak var delegate: EpisodeDetailViewmodelDelegate?
    private let repo: EpisodeRepository
    
    init(repo: EpisodeRepository = PTEpisodeRepository()) {
        self.repo = repo
    }
    
    func fetchDetails(with episode: PTEpisode) {
        Task {
            do {
                let details = try await repo.fetchDetails(with: episode.id)
                delegate?.loadData(with: details)
            } catch {
                delegate?.showError(with: error.localizedDescription)
            }
        }
    }
    
}

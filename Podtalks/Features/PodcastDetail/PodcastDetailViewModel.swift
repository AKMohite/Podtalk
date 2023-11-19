//
//  PodcastDetailViewModel.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 03/11/23.
//

import Foundation

protocol PodcastDetailViewModelDelegate: AnyObject {
    func updateUI(with detail: PTPodcastDetails)
    func showError(with message: String?)
}

final class PodcastDetailViewModel {
    
    weak var delegate: PodcastDetailViewModelDelegate?
    private let repo: PodcastRepository
    
    init(repo: PodcastRepository = PTPodcastRepository()) {
        self.repo = repo
    }
    
    func fetchDetails(with podcast: PTPodcast) {
        Task {
            do {
                let details = try await repo.fetchDetails(for: podcast.id, with: nil)
                DispatchQueue.main.async {
                    self.delegate?.updateUI(with: details)
                }
            } catch {
                DispatchQueue.main.async {
                    self.delegate?.showError(with: error.localizedDescription)
                }
            }
        }
    }
    
}

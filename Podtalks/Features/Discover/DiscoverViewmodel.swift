//
//  DiscoverViewmodel.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 26/10/23.
//

import Foundation

protocol DiscoverViewmodelDelegate: AnyObject {
    func updateUI(for model: DiscoverUI)
    func showError(with message: String?)
}

final class DiscoverViewmodel {
    
    private let genresRepo: GenreRepository
    private let podcastsRepo: PodcastRepository
    
    init(
        genresRepo: GenreRepository = PTGenreRepository(),
        podcastsRepo: PodcastRepository = PTPodcastRepository()
    ) {
        self.genresRepo = genresRepo
        self.podcastsRepo = podcastsRepo
    }
    
    weak var delegate: DiscoverViewmodelDelegate?
    
    private var genres: [TalkGenre] = []
    private var bestPodcasts: [PTPodcast] = []
    private var curatedPodcasts: [CuratedPodcast] = []
    
//    TODO: check for main queue
    @MainActor
    func load() {
//        genresRepo.getAll { [weak self] result in
//            switch result {
//            case .success(let genres):
//                self?.genres = genres
//                self?.delegate?.updateUI(for: DiscoverUI(genres: genres))
//                break
//            case .failure(let error):
//                errors.append(error)
//                self?.delegate?.showError(with: error.localizedDescription)
//                break
//            }
//        }
//        TODO: check for background queue
        Task {
            do {
                self.genres = try await genresRepo.getAll()
//                self.bestPodcasts = try await podcastsRepo.getBestPodcasts()
//                let curatedList = try await podcastsRepo.getCuratedPodcasts()
                async let bestPodcasts = podcastsRepo.getBestPodcasts()
                async let recentAddedPodcast = podcastsRepo.getRecentAddedPodcasts()
                async let curatedList = podcastsRepo.getCuratedPodcasts()
                let (podcasts, curatedPodcasts, newAddedPodcast) = try await (bestPodcasts, curatedList, recentAddedPodcast)
                self.bestPodcasts = podcasts
                self.curatedPodcasts = curatedPodcasts
                let topBanners = Array(podcasts.prefix(4))
                let bestList = Array(podcasts.dropFirst(4))
                self.delegate?.updateUI(for: DiscoverUI(genres: genres, topBanners: topBanners, bestPodcasts: bestList, recentAddedPodcasts: newAddedPodcast, curatedList: curatedPodcasts))
            } catch {
                self.delegate?.showError(with: error.localizedDescription)
            }
        }
    }
    
}

internal struct DiscoverUI {
    let genres: [TalkGenre]
    let topBanners: [PTPodcast]
    let bestPodcasts: [PTPodcast]
    let recentAddedPodcasts: [PTPodcast]
    let curatedList: [CuratedPodcast]
}

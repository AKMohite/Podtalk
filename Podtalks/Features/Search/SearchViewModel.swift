//
//  SearchViewModel.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 12/11/23.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func load(with genres: [TalkGenre])
    func refresh(with results: [PTSearchResults])
    func showError(with message: String?)
}

final class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    private let genreRepo: GenreRepository
    private let podcastRepo: PodcastRepository
    
    init(genreRepo: GenreRepository = PTGenreRepository(), podcastRepo: PodcastRepository = PTPodcastRepository()) {
        self.genreRepo = genreRepo
        self.podcastRepo = podcastRepo
    }
    
    func getAllGenres() {
        Task {
            do {
                let genres = try await genreRepo.getAll()
                DispatchQueue.main.async {
                    self.delegate?.load(with: genres)
                }
            } catch {
                delegate?.showError(with: error.localizedDescription)
            }
        }
    }
    
    func search(with query: String) {
        Task {
            do {
                async let podcasts = podcastRepo.searchPodcasts(with: query, page: 1)
                async let episodes = podcastRepo.searchEpisodes(with: query, page: 1)
                let (podcastResults, episodeResults) = try await (podcasts, episodes)
                let results = [
                    PTSearchResults.podcasts(podcastResults),
                    PTSearchResults.episodes(episodeResults)
                ]
                delegate?.refresh(with: results)
            } catch {
                delegate?.showError(with: error.localizedDescription)
            }
        }
    }
    
}

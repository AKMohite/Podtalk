//
//  SearchViewModel.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 12/11/23.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func load(with genres: [TalkGenre])
    func showError(with message: String?)
}

final class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    private let genreRepo: GenreRepository
    
    init(genreRepo: GenreRepository = PTGenreRepository()) {
        self.genreRepo = genreRepo
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
    
}

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
    
    init(genresRepo: GenreRepository = PTGenreRepository()) {
        self.genresRepo = genresRepo
    }
    
    weak var delegate: DiscoverViewmodelDelegate?
    
    private var genres: [TalkGenre] = []
    
    @MainActor
    func load() {
        
        var errors: [Error] = []
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
        Task {
            do {
                self.genres = try await genresRepo.getAll()
                self.delegate?.updateUI(for: DiscoverUI(genres: genres))
            } catch {
                self.delegate?.showError(with: error.localizedDescription)
            }
        }
    }
    
}

internal struct DiscoverUI {
    let genres: [TalkGenre]
}

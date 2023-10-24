//
//  GenreRepository.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

protocol GenreRepository {
    func getAll(completion: @escaping ([TalkGenre]) -> Void)
    func getGenre(by ids: [String]) -> [TalkGenre]
}

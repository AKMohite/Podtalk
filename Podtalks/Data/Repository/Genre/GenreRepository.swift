//
//  GenreRepository.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

protocol GenreRepository {
    func getAll(completion: @escaping (Result<[TalkGenre], Error>) -> Void)
    func getAll() async throws -> [TalkGenre]
    func getGenre(by ids: [Int16]) async throws -> [TalkGenre]
}

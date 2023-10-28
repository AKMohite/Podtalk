//
//  PTGenreRepository.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

final class PTGenreRepository: GenreRepository {
    private let apiClient: HttpClient
    private let genresDAO: GenreDAO
    
    init(apiClient: HttpClient = PodTalkHttpClient.shared, genresDAO: GenreDAO = PTGenreDAO()) {
        self.apiClient = apiClient
        self.genresDAO = genresDAO
    }
    
    func getAll(completion: @escaping (Result<[TalkGenre], Error>) -> Void) {
        apiClient.execute(request: PodtalkHttpRequest(endpoint: .genres), expecting: GenresDTO.self) { result in
            switch result {
            case .success(let data):
                let genres = data.genres.compactMap { genre in
                    TalkGenre(id: genre.id, name: genre.name)
                }
//                TODO: save in local DB
                completion(.success(genres))
                return
            case .failure(let error):
//                TODO: add log errors
                completion(.failure(error))
                return
            }
        }
    }
    
    fileprivate func fetchGenresFromRemote() async throws -> [TalkGenre] {
        let dto = try await apiClient.execute(request: PodtalkHttpRequest(endpoint: .genres), expecting: GenresDTO.self)
        _ = try await genresDAO.addAll(dto: dto.genres)
        let genres = dto.genres.compactMap { genre in
            TalkGenre(id: genre.id, name: genre.name)
        }
        return genres
    }
    
    func getAll() async throws -> [TalkGenre] {
        let localGenres = try await genresDAO.getAll()
        if !localGenres.isEmpty {
            let date: Date = localGenres.first!.created_at
            if validate(date, against: .now) {
                return localGenres.map { genre in
                    TalkGenre(id: Int(genre.id), name: genre.name)
                }
            } else {
                return try await fetchGenresFromRemote()
            }
        } else {
            return try await fetchGenresFromRemote()
        }
    }
    
    func getGenre(by ids: [String]) async throws -> [TalkGenre] {
        guard let result = try? await genresDAO.get(by: ids) else {
            return []
        }
        let models = result.map { genre in
            TalkGenre(id: Int(genre.id), name: genre.name)
        }
        return models
    }
    
    private func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = Calendar(identifier: .gregorian).date(byAdding: .day, value: 1, to: timestamp) else {
            return false
        }
        return date < maxCacheAge
    }
    
    
}

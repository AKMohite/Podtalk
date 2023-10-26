//
//  PTGenreRepository.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

final class PTGenreRepository: GenreRepository {
    private let apiClient: HttpClient
    
    init(apiClient: HttpClient = PodTalkHttpClient.shared) {
        self.apiClient = apiClient
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
    
    func getAll() async throws -> [TalkGenre] {
        let dto = try await apiClient.execute(request: PodtalkHttpRequest(endpoint: .genres), expecting: GenresDTO.self)
        let genres = dto.genres.compactMap { genre in
            TalkGenre(id: genre.id, name: genre.name)
        }
        return genres
    }
    
    func getGenre(by ids: [String]) -> [TalkGenre] {
        return []
    }
    
    
}

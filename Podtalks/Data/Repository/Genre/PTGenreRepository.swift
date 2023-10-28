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
    
    fileprivate func fetchGenresFromRemote() async throws -> [TalkGenre] {
        let dto = try await apiClient.execute(request: PodtalkHttpRequest(endpoint: .genres), expecting: GenresDTO.self)
        //        let entity = GenreEntity(context: PersistentStorage.shared.context)
        //        let dataGenre = dto.genres[0]
        //        entity.id = Int16(dataGenre.id)
        //        entity.name = dataGenre.name
        //        entity.parent_id = Int16(dataGenre.parentId)
        //        PersistentStorage.shared.saveContext()
        let genres = dto.genres.compactMap { genre in
            TalkGenre(id: genre.id, name: genre.name)
        }
        return genres
    }
    
    func getAll() async throws -> [TalkGenre] {
        guard let localGenres = try? PersistentStorage.shared.context.fetch(GenreEntity.fetchRequest()) as? [GenreEntity] else {
            return try await fetchGenresFromRemote()
        }
        if localGenres.isEmpty {
            return try await fetchGenresFromRemote()
        }
        return localGenres.map { genre in
            TalkGenre(id: Int(genre.id), name: genre.name)
        }
    }
    
    func getGenre(by ids: [String]) -> [TalkGenre] {
        return []
    }
    
    
}

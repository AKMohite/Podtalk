//
//  PTGenreRepository.swift
//  Podtalks
//
//  Created by Nitin Sakhare + on 24/10/23.
//

import Foundation

final class PTGenreRepository: GenreRepository {
    private let apiClient: HttpClient
    
    init(apiClient: HttpClient) {
        self.apiClient = apiClient
    }
    
    func getAll(completion: @escaping ([TalkGenre]) -> Void) {
        apiClient.execute(request: PodtalkHttpRequest(endpoint: .genres), expecting: GenresDTO.self) { result in
            switch result {
            case .success(let data):
                let genres = data.genres.compactMap { genre in
                    TalkGenre(id: genre.id, name: genre.name)
                }
//                TODO: save in local DN
                completion(genres)
                return
            case .failure(let error):
//                TODO: add log errors
                print(error)
                break
            }
            completion([])
        }
    }
    
    func getGenre(by ids: [String]) -> [TalkGenre] {
        return []
    }
    
    
}

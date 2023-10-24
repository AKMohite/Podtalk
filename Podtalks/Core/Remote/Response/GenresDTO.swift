//
//  GenresDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

struct GenresDTO: Decodable {
    let genres: [GenreDTO]
}

struct GenreDTO: Decodable {
    let id: Int
    let name: String
    let parentId: Int
    
    enum CodingKeys: String, CodingKey {
        case parentId = "parent_id"
        case id
        case name
    }
}

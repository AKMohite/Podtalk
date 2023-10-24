//
//  GenresDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

struct GenresDTO {
    let genres: [GenreDTO]
}

struct GenreDTO {
    let id: Int
    let name: Int
    let parentId: Int
}

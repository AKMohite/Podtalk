//
//  PaginatedDTO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

struct PaginatedDTO<Item> {
    let total: Int
    let hasNext: Bool
    let pageNumber: Int
    let hasPrevious: Bool
    let nextPageNumber: Int?
    let previousPageNumber: Int
}

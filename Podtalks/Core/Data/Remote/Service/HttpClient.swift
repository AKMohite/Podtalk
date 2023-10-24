//
//  HttpClient.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

protocol HttpClient {
    func execute<Data: Decodable>(request: PodtalkHttpRequest, expecting type: Data.Type, completion: @escaping (Result<Data, Error>) -> Void) -> Void
}

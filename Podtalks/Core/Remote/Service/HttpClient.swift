//
//  HttpClient.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

protocol HttpClient {
    func execute<Data>(url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> Void
}

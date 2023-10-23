//
//  PodTalkHttpClient.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

final class PodTalkHttpClient: HttpClient {
    func execute<Data>(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
        }
        task.resume()
    }
    
    
}

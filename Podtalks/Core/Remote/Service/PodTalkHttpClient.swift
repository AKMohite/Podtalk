//
//  PodTalkHttpClient.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

final class PodTalkHttpClient: HttpClient {
    
    static let shared = PodTalkHttpClient()
    
    struct APIError: Error {
        let statusCode: Int?
        let message: String?
    }
    
    func execute<Data: Decodable>(
        url: URL,
        expecting type: Data.Type,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                let response = response as? HTTPURLResponse
                let responseCode = response?.statusCode
                var message = "Something went wrong Please try again later"
//                TODO: extract error response
                completion(.failure(APIError(statusCode: response?.statusCode, message: message)))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
//                TODO: send proper message
                completion(.failure(APIError(statusCode: nil, message: "Could not parse data")))
            }
        }
        task.resume()
    }
    
    
}

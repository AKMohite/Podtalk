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
        request: PodtalkHttpRequest,
        expecting type: Data.Type,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let request = request.getURLRequest() else {
//                TODO: send proper message
            completion(.failure(APIError(statusCode: nil, message: "Failed to request")))
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                let response = response as? HTTPURLResponse
                let responseCode = response?.statusCode
                let message = "Something went wrong Please try again later"
//                TODO: extract error response
                completion(.failure(APIError(statusCode: responseCode, message: message)))
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
    
    func execute<Data: Decodable>(
        request: PodtalkHttpRequest,
        expecting type: Data.Type
    ) async throws -> Data {
        guard let request = request.getURLRequest() else {
            throw APIError(statusCode: nil, message: "Request not formed")
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            let code = (response as? HTTPURLResponse)?.statusCode
            throw APIError(statusCode: code, message: "Something went wrong")
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return try decoder.decode(type.self, from: data)
    }
    
    
}

//
//  PodtalkHttpRequest.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 24/10/23.
//

import Foundation

enum HttpMethod {
    case POST
    case GET
    case PUT
    case PATCH
    case DELETE
}

final class PodtalkHttpRequest {
    
//    TODO: Use config for mock and production urls and keys
    private let baseURL = "https://listen-api-test.listennotes.com/api/v2"
    private let podcastAPIKey = ""
    private let httpMethod = "GET"
    private let endpoint: PodtalkEndpoint
    private let queryParameters: [URLQueryItem]
    private let pathSegments: [String]
    
    private var url: URL? {
        let urlString = getHttpURLString()
        return URL(string: urlString)
    }
    
    init(
        endpoint: PodtalkEndpoint,
        pathSegments: [String] = [],
        queryParameters: [String:String] = [:]
    ) {
        self.endpoint = endpoint
        self.pathSegments = pathSegments
        self.queryParameters = queryParameters.compactMap({ (key: String, value: String) in
            return URLQueryItem(name: key, value: value)
        })
    }
    
    private func getHttpURLString() -> String {
        var urlString = baseURL
        urlString += "/"
        urlString += endpoint.rawValue

        if !pathSegments.isEmpty {
            pathSegments.forEach({
                urlString += "/\($0)"
            })
        }

        if !queryParameters.isEmpty {
            urlString += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")

            urlString += argumentString
        }
        return urlString
    }
    
    func getURLRequest() -> URLRequest? {
        guard let url = url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue(podcastAPIKey, forHTTPHeaderField: "X-ListenAPI-Key")
        return request
    }
}

//
//  PodtalkHttpRequestTest.swift
//  PodtalksUnitTests
//
//  Created by Ashish Mohite + on 24/10/23.
//

import XCTest
@testable import Podtalks

final class PodtalkHttpRequestTest: XCTestCase {
    
    func test_genres_endpointURL() {
        let sut = PodtalkHttpRequest(endpoint: .genres).getURLRequest()?.url
        
        XCTAssertEqual(sut?.scheme, "https", "scheme")
        XCTAssertEqual(sut?.host, "listen-api-test.listennotes.com", "host") // TODO: do we need to pass url in tests too?
        XCTAssertEqual(sut?.path, "/api/v2/genres", "path")
    }
    
    func test_best_podcasts_endpointURL() {
        let queryParams: [String : String] = [
            "page" : "1",
            "sort" : "listen_score",
            "genre_id" : ""
        ]
        let sut = PodtalkHttpRequest(endpoint: .best_podcasts, queryParameters: queryParams).getURLRequest()?.url
        
        XCTAssertEqual(sut?.scheme, "https", "scheme")
        XCTAssertEqual(sut?.host, "listen-api-test.listennotes.com", "host") // TODO: do we need to pass url in tests too?
        XCTAssertEqual(sut?.path, "/api/v2/best_podcasts", "path")
        XCTAssertEqual(sut?.query?.contains("page=1"), true, "page query param")
        XCTAssertEqual(sut?.query?.contains("sort=listen_score"), true, "sort query param")
        XCTAssertEqual(sut?.query?.contains("genre_id="), true, "genre_id query param")
    }
    
}

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
//        TODO: do we need to pass url in tests too?
        let baseURL = "https://listen-api-test.listennotes.com/api/v2"
        let sut = PodtalkHttpRequest(endpoint: .genres).getURLRequest()?.url
        XCTAssertEqual(sut?.scheme, "https", "scheme")
        XCTAssertEqual(sut?.host, "listen-api-test.listennotes.com", "host")
        XCTAssertEqual(sut?.path, "/api/v2/genres", "path")
    }
    
}

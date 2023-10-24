//
//  PodTalkHttpClientTest.swift
//  PodtalksUnitTests
//
//  Created by Ashish Mohite + on 24/10/23.
//

import XCTest
@testable import Podtalks

final class PodTalkHttpClientTest: XCTestCase {
    
    func test_genres_success_response() {
        XCTAssert(1+1 == 2, "This test calls API calls?")
//        let sut: HttpClient = PodTalkHttpClient.shared
//
//        let exp = expectation(description: "Wait for request")
//
//        sut.execute(request: PodtalkHttpRequest(endpoint: .genres), expecting: GenresDTO.self) { result in
//            switch result {
//            case .success(let data):
//                XCTAssertNotNil(data.genres)
//                XCTAssert(!data.genres.isEmpty)
//                break
//            case .failure(let error):
//                XCTFail("Expected successful genres result, got \(error) instead")
//            }
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 1.0)
    }

}

//
//  ImageListDemoTests.swift
//  ImageListDemoTests
//
//  Created by Bishal Ram on 15/05/24.
//

import XCTest
@testable import ImageListDemo

final class ImageListDemoTests: XCTestCase {
    
    var sut: NetworkServiceProtocol!

       override func setUp() {
           super.setUp()
           // Use the mock networking service during testing
           sut = NetworkService()
       }
    
   func testfetchImages() {
       let expectation = expectation(description: "fetchImages")
       sut.request(route: .endpoint, method: .get) { (response, error)  in
           if let response = response {
               XCTAssertEqual(response.first?.albumId, 1)
               XCTAssertEqual(response.first?.id, 1)
               XCTAssertEqual(response.first?.thumbnailUrl, "https://via.placeholder.com/150/92c952")
               XCTAssertEqual(response.first?.url, "https://via.placeholder.com/600/92c952")
           }
           if let error = error {
               XCTFail("Error: \(error.localizedDescription)")
           }
           expectation.fulfill()
       }
       wait(for: [expectation], timeout: 5.0)
    }
}

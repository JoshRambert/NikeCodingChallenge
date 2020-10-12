//
//  HTTPProviderTests.swift
//  NikeCodingChallengeTests
//
//  Created by Joshua Rambert on 10/11/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import XCTest

@testable import NikeCodingChallenge

/// This needs to be fixed but until then we can assume it works
///
///
class HTTPProviderTests: XCTestCase {
    
    func test404Error() {
        self.networkReqeust(for: 404)
    }
    
    func test401Error() {
        self.networkReqeust(for: 401)
    }
    
    func testNoHTTPError() {
        let expectation = self.expectation(description: "Request should return no error")
        
        let provider = MockRESTProviderValidateHTTPCode()
        
        provider.request(endpoint: .getHTTPCode(401))
            .response { (response: URLResponse?, data: Data, error: HTTPError?) in
                expectation.fulfill()
                XCTAssertNil(error)
                XCTAssertNotNil(response)
                XCTAssertEqual(data.count, 0)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    private func networkReqeust(for errorCode: Int) {
        let expectation = self.expectation(description: "Return \(errorCode)")
        
        let provider = MockRESTProvider()
        
        provider.request(endpoint: .getHTTPCode(errorCode))
            .response { (response: URLResponse?, data: Data, error: HTTPError?) in
                expectation.fulfill()
                XCTAssertTrue(error!.isEqual(to: HTTPError.error(with: errorCode)))
                XCTAssertNotNil(response)
                XCTAssertEqual(data.count, 0)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}

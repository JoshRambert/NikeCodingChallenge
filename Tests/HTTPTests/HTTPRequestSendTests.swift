//
//  HTTPRequestSendTests.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 10/10/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import XCTest

@testable import NikeCodingChallenge

class HTTPRequestSendTests: XCTestCase {
    
    var client: HTTPNetworkClientProtocol?
    
    struct Constants {
        static let timeout: TimeInterval = 5
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        client = HTTPNetworkClient(for: "https://httpbin.org")
    }
    
    func testSendGET() {
        testSendWith(endpoint: .get, method: HTTPMethod.get.rawValue)
    }
    
    func testSendDELETE() {
        testSendWith(endpoint: .delete, method: HTTPMethod.delete.rawValue)
    }
    
    
    private func testSendWith(endpoint: Endpoint, method: String) {
        let expectation = self.expectation(description: "Successful \(method) Request")
        
        let request = client?.request(endpoint: endpoint)
        request?.response { (response: URLResponse?, data: Data, error: Error?) in
            expectation.fulfill()
            XCTAssertNotNil(response)
            XCTAssertNil(error)
            XCTAssertGreaterThan(data.count, 0)
        }
        
        waitForExpectations(timeout: Constants.timeout, handler: nil)
    }
    
    private func testSendWithJSON(endpoint: Endpoint, method: String) {
        let expectation = self.expectation(description: "Successful \(method) Request")
        
        let request = client?.request(endpoint: endpoint)
        request?.responseJSON { (response: HTTPResponse<Any>) in
            expectation.fulfill()
            XCTAssertEqual(response.response?.statusCode, 200)
            XCTAssertNotNil(response.result.value)
            XCTAssertNil(response.result.error)
            XCTAssertGreaterThan(response.data.count, 0)
        }
        
        waitForExpectations(timeout: Constants.timeout, handler: nil)
    }
    
}

//
//  HTTPRequestBuildingTests.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 10/11/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import XCTest

@testable import NikeCodingChallenge

class HTTPRequestBuildingTests: XCTestCase {
    
    struct Constants {
        static let customParameters: [String: Any] = ["abc":"def", "test":123]
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    func testGETRequestBuild() {
        let provider = MockRESTProvider()
        
        let request = provider.request(endpoint: .get)
        
        XCTAssertEqual(request.urlRequest.httpMethod, "GET")
        XCTAssertEqual(request.urlRequest.url?.absoluteString, "\(provider.baseURL)/get")
    }
    
    func testDELETERequestBuild() {
        let provider = MockRESTProvider()
        
        let request = provider.request(endpoint: .delete)
        
        XCTAssertEqual(request.urlRequest.httpMethod, "DELETE")
        XCTAssertEqual(request.urlRequest.url?.absoluteString, "\(provider.baseURL)/delete")
    }
    
    func testGETWithCustomHeaders() {
        let provider = MockRESTProvider()
        
        let request = provider.request(endpoint: .getHTTPHeaders(["CustomHeader": "Value"]))
        
        XCTAssertEqual(request.urlRequest.allHTTPHeaderFields!["CustomHeader"], "Value")
    }
    
    func testGETWithDefaultHeaders() {
        let provider = MockRESTProviderWithHeaders()
        
        let request = provider.request(endpoint: .getHTTPHeaders(nil))
        
        XCTAssertEqual(request.urlRequest.allHTTPHeaderFields!["HeaderTestKey"], "HeaderTestValue")
    }
    
    func testGETWithAdditionalHeaders() {
        let provider = MockRESTProviderWithHeaders()
        
        let request = provider.request(endpoint: .getHTTPHeaders(["CustomHeader": "Value"]))
        
        XCTAssertEqual(request.urlRequest.allHTTPHeaderFields!["CustomHeader"], "Value")
        XCTAssertEqual(request.urlRequest.allHTTPHeaderFields!["HeaderTestKey"], "HeaderTestValue")
    }
    
}

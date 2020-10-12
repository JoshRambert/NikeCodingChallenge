//
//  MockProviders.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 10/10/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

@testable import NikeCodingChallenge

class MockRESTProvider: HTTPProviderProtocol {
    
    var baseURL: URL { get { return URL(string: "https://httpbin.org")! }}
    
    var additionalHeaders: [String: String] = [:]
    
}

class MockRESTProviderWithHeaders: HTTPProviderProtocol {
    
    var baseURL: URL { get { return URL(string: "https://httpbin.org")! }}

    var additionalHeaders: [String : String] = ["HeaderTestKey" : "HeaderTestValue"]
    
}

class MockRESTProviderWithParameters: HTTPProviderProtocol {
    
    var baseURL: URL { get { return URL(string: "https://httpbin.org")! }}

    var additionalParameters: [String : Any] = ["ParamsTestToken" : 12345]
    
}


class MockRESTProviderValidateHTTPCode: HTTPProviderProtocol {
    
    var baseURL: URL { get { return URL(string: "https://httpbin.org")! }}
    
    func validate(response: HTTPURLResponse?, data: Data, error: Error?) -> HTTPError? {
        return nil
    }
    
}

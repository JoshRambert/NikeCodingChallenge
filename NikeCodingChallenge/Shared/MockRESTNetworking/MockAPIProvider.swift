//
//  MockAPIProvider.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 10/9/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

protocol MockAPIProviderProtocol: HTTPProviderProtocol {
    
    /// Handle the endpoint request and return it for response completion handling
    /// Requests are prepared and asyncronously completed
    ///
    /// - Paramter endpoint: The endpoint to run the mocked request on
    /// - Return:  An HTTP request that will be completed asyncronously
    func request(endpoint: Endpoint) -> HTTPRequest
    
    /// Handle the completion of a specific request. This method typically uses
    /// the endpoints values to run an appropriate MockAPIRoute completion
    ///
    /// The router should work similarly to the route handling you'd build on
    /// an actual REST server
    ///
    /// This example returns a 404 error for all endpoints except index "/"
    /// For index it returns a custom completion handler that would be extended
    /// in MockAPIRoutes
    ///
    /// - Parameters:
    ///     - endpoint: The endpoint to run a mocked response on.
    ///     - request: The mocked reqeust to complete
    func router(endpoint: Endpoint, request: HTTPRequest)
    
}

open class MockAPIProvider: MockAPIProviderProtocol {
    
    public func request(endpoint: Endpoint) -> HTTPRequest {
        let request = HTTPRequest(urlRequest: URLRequest(url: baseURL), provider: self)
        
        DispatchQueue.main.async {
            self.router(endpoint: endpoint, request: request)
        }
        
        return request
    }
    
    func router(endpoint: Endpoint, request: HTTPRequest) {
        switch endpoint.path {
        
        default:
            MockAPIRoutes.notFound(request: request)
        }
    }
    
    public var baseURL: URL = URL(string: "https://0.0.0.0/")!
}

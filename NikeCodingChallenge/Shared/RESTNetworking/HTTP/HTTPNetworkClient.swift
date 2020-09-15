//
//  HTTPNetworkClient.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/13/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public protocol HTTPNetworkClientProtocol {
    
    init(for baseURL: String)
    
    init(with provider: HTTPProviderProtocol)
    
    func request(endpoint: Endpoint) -> HTTPRequest
}

public class HTTPNetworkClient: HTTPNetworkClientProtocol {
    
    private var provider: HTTPProviderProtocol
    
    public required init(for baseURL: String) {
        let url = URL(string: baseURL)!
        
        self.provider = HTTPProvider(baseURL: url)
    }
    
    public required init(with provider: HTTPProviderProtocol) {
        self.provider = provider
    }
    
    public func request(endpoint: Endpoint) -> HTTPRequest {
        return provider.request(endpoint: endpoint)
    }
}

//
//  Endpoint.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/13/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public struct Endpoint {
    
    public let path: String
    
    public let method: HTTPMethod
    
    public let encoding: ParameterEncodingProtocol
    
    public let parameters: [String: Any]?
    
    public let headers: [String: String]?
    
    public init(path: String, method: HTTPMethod = .get, encoding: ParameterEncodingProtocol, parameters: [String: Any]?, headers: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
    }
}



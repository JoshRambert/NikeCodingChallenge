//
//  Endpoint.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/13/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public struct Endpoint {
    
    let path: String
    
    let method: HTTPMethod
    
    let encoding: ParameterEncodingProtocol
    
    let parameters: [String: Any]?
    
    let headers: [String: String]?
    
    public init(path: String, method: HTTPMethod = .get, encoding: ParameterEncodingProtocol, parameters: [String: Any]?, headers: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.encoding = encoding
        self.parameters = parameters
        self.headers = headers
    }
}



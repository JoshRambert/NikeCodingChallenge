//
//  URLRequestConvertible.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/12/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public protocol URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    
    public var urlRequest: URLRequest? { return try? asURLRequest() }
}

extension URLRequest: URLRequestConvertible {
    
    public func asURLRequest() throws -> URLRequest {
        return self
    }
}

//
//  HTTPResult.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/11/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public enum HTTPResult<Value> {
    case success(Value)
    case failure(HTTPError)
    
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            return nil
        }
    }
    
    public var error: HTTPError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

extension HTTPResult {
    
    public func map<U>(_ f: (Value) -> U) -> HTTPResult<U> {
        switch self {
        case .success(let value):
            return .success(f(value))
        case .failure(let error):
            return .failure(error)
        }
    }
}

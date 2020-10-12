//
//  TestEndpoints.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 10/10/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

@testable import NikeCodingChallenge

struct TestModel: Codable  {
    var title: String
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case message
    }
}

struct TestModelSmall: Codable {
    var title: String
}

extension Endpoint {
    
    static let delete = Endpoint(path: "/delete",
                                 method: .delete,
                                 encoding: HTTPURLEncoding.default,
                                 parameters: nil)
    
    static let get = Endpoint(path: "/get", method: .get, encoding: HTTPURLEncoding.default, parameters: nil)
    
    static let getHTTPCode = {(httpCode: Int) in Endpoint(path: "/status/", encoding: HTTPURLEncoding.default, parameters: nil)}
    
    static let getHTTPHeaders = {(headers: [String: String]?) in Endpoint(path: "/headers", encoding: HTTPURLEncoding.default, parameters: nil, headers: headers)}
    
    
}

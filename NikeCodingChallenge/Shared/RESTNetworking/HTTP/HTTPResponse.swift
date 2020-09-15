//
//  HTTPResponse.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/12/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public class HTTPResponse<Value> {
    
    public let response: HTTPURLResponse?
    
    public let data: Data
    
    public let result: HTTPResult<Value>
    
    public init(response: HTTPURLResponse?, data: Data, result: HTTPResult<Value>) {
        self.response = response
        self.result = result
        self.data = data 
    }
}

//
//  HTTPMethod.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/11/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

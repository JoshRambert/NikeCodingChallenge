//
//  AlbumsError.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 10/12/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public enum AlbumsError: Error {
    
    case invalidParameters
    
    case serverDown
    
    case notConnectedToInternet
    
    case invalidUrl
    
    case unknown(String)
    
    static func error(with error: Error) -> AlbumsError {
        return AlbumsError.unknown(error.localizedDescription)
    }
}

extension AlbumsError {
    
    public func isEqual(to error: AlbumsError) -> Bool {
        return error == self
    }
}

extension AlbumsError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidParameters:
            return "The parameters in the reqeust are invalid"
        case .serverDown:
            return "Server Down"
        case .notConnectedToInternet:
            return "There is no internet connection"
        case .invalidUrl:
            return "The URL is incorrect for the endpoint"
        case .unknown(let error):
            return "\(error)"
        }
    }
}

extension AlbumsError: Equatable {
    
    public static func == (lhs: AlbumsError, rhs: AlbumsError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidParameters, .invalidParameters):
            return true
            
        case (.serverDown, .serverDown):
            return true
            
        case (.notConnectedToInternet, .notConnectedToInternet):
            return true
            
        case (.invalidUrl, .invalidUrl):
            return true
            
        case (.unknown(let lErrorString), .unknown(let rErrorString)):
            return lErrorString == rErrorString
            
        default:
            return false
        }
    }
    
}

//
//  HTTPError.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/11/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public enum HTTPError: Error {
    
    case invalidURL(String)
    
    case parameterEncodingFailed(reason: HTTPError.ParameterEncodingReason)
    
    case responseSerializationFailed(reason: HTTPError.ResponseSerializationReason)
    
    case http(Int)
    
    case couldNotFindHost
    
    case noInternetConnection
    
    case unknown(String)
    
    public enum ResponseSerializationReason {
        case jsonSerializationFailed(error: Error)
    }
    
    public enum ParameterEncodingReason {
        case missingURL
        case jsonEncodingFailed(error: Error)
        case missingParameters
    }
    
    static func error(with error: Error) -> HTTPError {
        return HTTPError.unknown(error.localizedDescription)
    }
    
    static func error(with httpCode: Int) -> HTTPError {
        return .http(httpCode)
    }
}

extension HTTPError {

    public func isEqual(to error: HTTPError) -> Bool {
        return error == self
    }
}

extension HTTPError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "Invalid URL: \(url)"
        case .parameterEncodingFailed(let reason):
            return reason.localizedDescription
        case .responseSerializationFailed(let reason):
            return reason.localizedDescription
        case .http(let httpCode):
            return "Request failed with HTTP Error code: \n\(httpCode)"
        case .couldNotFindHost:
            return "Could not find host."
        case .noInternetConnection:
            return "No Internet conneciton available for the request."
        case .unknown(let error):
            return "Request failed with unknown error: \n\(error)"
        }
    }
    
}

extension HTTPError.ParameterEncodingReason {
    
    var localizedDescription: String {
        switch self {
        case .missingURL:
            return "URL Request was missing a URL"
        case .jsonEncodingFailed(let error):
            return "Failed to encode JSON due to the following error: \n\(error.localizedDescription)"
        case .missingParameters:
            return "Request was missing parameters for URL encoding"
        }
    }
}

extension HTTPError.ParameterEncodingReason: Equatable {
    
    public static func ==(lhs: HTTPError.ParameterEncodingReason, rhs: HTTPError.ParameterEncodingReason) -> Bool {
        switch (lhs, rhs) {
        case (.missingURL, .missingURL),
             (.missingParameters, .missingParameters):
            return true
        case (.jsonEncodingFailed(let lError), .jsonEncodingFailed(let rError)):
            return lError.localizedDescription == rError.localizedDescription
        default:
            return false
        }
    }
}

extension HTTPError.ResponseSerializationReason {
    
    var localizedDescription: String {
        switch self {
        case .jsonSerializationFailed(let error):
            return "Failed to serialize JSON due to the following error: \n\(error.localizedDescription)"
        }
    }
}

extension HTTPError.ResponseSerializationReason: Equatable {
    
    public static func ==(lhs: HTTPError.ResponseSerializationReason, rhs: HTTPError.ResponseSerializationReason) -> Bool {
        switch (lhs, rhs) {
        case (.jsonSerializationFailed(let lError), .jsonSerializationFailed(let rError)):
            return lError.localizedDescription == rError.localizedDescription
        }
    }
}

extension HTTPError: Equatable {
    
    public static func ==(lhs: HTTPError, rhs: HTTPError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL(let lURL), .invalidURL(let rURL)):
            return lURL == rURL
        case (.parameterEncodingFailed(let lReason), .parameterEncodingFailed(let rReason)):
            return lReason == rReason
        case (.responseSerializationFailed(let lReason), .responseSerializationFailed(let rReason)):
            return lReason == rReason
        case (.http(let lErrorCode), .http(let rErrorCode)):
            return lErrorCode == rErrorCode
        case (.couldNotFindHost, .couldNotFindHost):
            return true
        case (.noInternetConnection, .noInternetConnection):
            return true
        case (.unknown(let lErrorString), .unknown(let rErrorString)):
            return lErrorString == rErrorString
        default:
            return false
        }
    }
}

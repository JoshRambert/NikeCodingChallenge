//
//  ParameterEncoding.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/12/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncodingProtocol {
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest
}

public struct HTTPURLEncoding: ParameterEncodingProtocol {
    
    public static var `default`: HTTPURLEncoding { return HTTPURLEncoding() }
    
    public let intent: Intent
    
    public enum Intent {
        case methodDefined, queryStirng, httpBody
    }
    
    public init(intent: Intent = .methodDefined) {
        self.intent = intent
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters, !parameters.isEmpty else { return urlRequest }
        
        if let method = HTTPMethod(rawValue: urlRequest.httpMethod ?? "get"), encodeParameteresInURL(with: method) {
            guard let url = urlRequest.url else {
                throw HTTPError.parameterEncodingFailed(reason: .missingURL)
            }
            
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty else {
                throw HTTPError.parameterEncodingFailed(reason: .missingParameters)
            }
            
            let paramString = (parameters.map { "\($0)=\($1)" } as [String]).joined(separator: "&")
            let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "" ) + paramString
            urlComponents.percentEncodedQuery = percentEncodedQuery
            urlRequest.url = urlComponents.url
        } else {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                //DO NOTHING FOR NOW
            }
            
            let paramString = (parameters.map { "\($0)=\($1)" } as [String]).joined(separator: "&")
            urlRequest.httpBody = paramString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        }
        
        return urlRequest
    }
    
    private func encodeParameteresInURL(with method: HTTPMethod) -> Bool {
        switch intent {
        case .queryStirng:
            return true
        case .httpBody:
            return false
        default:
            break
        }
        
        switch method {
        case .get, .head, .delete:
            return true
        default:
            return false
        }
    }
}

public struct HTTPJSONEncoding: ParameterEncodingProtocol {
    
    public static var `default`: HTTPJSONEncoding { return HTTPJSONEncoding() }
    
    public let options: JSONSerialization.WritingOptions
    
    public init(options: JSONSerialization.WritingOptions = []){
        self.options = options
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return urlRequest }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                //DO NOTHING FOR NOW
            }
            
            urlRequest.httpBody = data
        } catch {
            throw HTTPError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
}

public struct HTTLURLEncoding: ParameterEncodingProtocol {
    
    public static var `default`: HTTPURLEncoding { return HTTPURLEncoding() }
    
    public let intent: Intent
    
    public enum Intent {
        case methodDefined, queryString, httpBody
    }
    
    public init(intent: Intent = .methodDefined) {
        self.intent = intent
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters, !parameters.isEmpty else { return urlRequest }
        
        if let method = HTTPMethod(rawValue: urlRequest.httpMethod ?? "get"), encodeParametersInURL(with: method) {
            guard let url = urlRequest.url else {
                throw HTTPError.parameterEncodingFailed(reason: .missingURL)
            }
            
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty else {
                throw HTTPError.parameterEncodingFailed(reason: .missingParameters)
            }
            
            let paramString = (parameters.map { "\($0)=\($1)" } as [String]).joined(separator: "&")
            let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + paramString
            urlComponents.percentEncodedQuery = percentEncodedQuery
            urlRequest.url = urlComponents.url
        } else {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                //Do nothing for now
            }
            
            let paramString = (parameters.map { "\($0)=\($1)" } as [String]).joined(separator: "&")
            urlRequest.httpBody = paramString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            
        }
        
        return urlRequest
    }
    
    private func encodeParametersInURL(with method: HTTPMethod) -> Bool {
        switch intent{
        case .queryString:
            return true
        case .httpBody:
            return false
        default:
            break
        }
        
        switch method {
        case .get, .head, .delete:
            return true
        default:
            return false
        }
    }
}

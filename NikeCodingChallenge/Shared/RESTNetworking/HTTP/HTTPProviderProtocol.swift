//
//  HTTPProviderProtocol.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/13/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public protocol HTTPProviderProtocol {
    
    var baseURL: URL { get }
    
    var delegate: SessionManagerDelegate { get }
    
    var session: URLSession { get }
    
    var additionalHeaders: [String: String] { get }
    
    var additionalParameters: [String: Any] { get }
    
    func validate(response: HTTPURLResponse?, data: Data, error: Error?) -> HTTPError?
    
    func shouldContinue(with error: HTTPError) -> Bool
    
    func request(endpoint: Endpoint) -> HTTPRequest
    
}

public extension HTTPProviderProtocol {
    
    var session: URLSession {
        return URLSession(configuration: .default, delegate: delegate, delegateQueue: OperationQueue.main)
    }
    
    var delegate: SessionManagerDelegate { return SessionManager.default }
    
    var additionalHeaders: [String: String] { return [String: String]() }
    
    var additionalParameters: [String: Any] { return [String: Any]() }
    
    func validate(response: HTTPURLResponse?, data: Data, error: Error?) -> HTTPError? {
        
        guard error == nil else { return HTTPError.error(with: error!) }
        
        guard let response = response else { return HTTPError.unknown("Response and error are nil") }
        
        return response.statusCode > 399 ? HTTPError.error(with: response.statusCode) : nil
        
    }
    
    func shouldContinue(with error: HTTPError) -> Bool {
        return true
    }
    
    func request(endpoint: Endpoint) -> HTTPRequest {
        
        let path = endpoint.path
        
        var request = URLRequest(url: baseURL)
        
        if let components = URLComponents(string: path), let url = components.url(relativeTo: baseURL) {
            request = URLRequest(url: url)
        }
        
        var params = additionalParameters
        
        if let endpointParams = endpoint.parameters {
            params = additionalParameters.merging(endpointParams) { $1 }
        }
        
        do {
            request = try endpoint.encoding.encode(request, with: params)
        } catch (let error) {
            let httpError = error as? HTTPError
            let r = HTTPRequest(urlRequest: request, provider: self)
            r.didComplete(response: nil, error: httpError ?? HTTPError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error)))
        }
        
        request.httpMethod = endpoint.method.rawValue
        
        var headers = additionalHeaders
        
        if let endpointHeaders = endpoint.headers {
            headers = additionalHeaders.merging(endpointHeaders) { $1 }
        }
        
        headers.forEach ({
            request.setValue($1, forHTTPHeaderField: $0)
        })
        
        let r = HTTPRequest(urlRequest: request, provider: self)
        
        let task = session.dataTask(with: request)
        delegate.requests[task] = r
        task.resume()
        
        return r
    }
    
}

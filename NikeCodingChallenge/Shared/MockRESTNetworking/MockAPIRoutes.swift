//
//  MockAPIRoutes.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 10/8/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

struct MockAPIRoutes {
    
    // MARK: Network Condition Routes
    
    /// Complete the HTTP Request with error NSURLErrorNotConnectedToInternet
    /// - Parameter request: the request to complete
    static func noInternet(request: HTTPRequest) {
        completeRequest(request: request, nsErrorCode: NSURLErrorNotConnectedToInternet)
    }
    
    /// Complete the HTTP Request with error NSURLCannotFindHost
    /// - Parameter request: the request to complete
    static func hostNotFound(request: HTTPRequest) {
        completeRequest(request: request, nsErrorCode: NSURLErrorCannotFindHost)
    }
    
    // MARK: Success Routes (With no Data)
    
    /// Complete the HTTP Request with a 201 - Created
    /// - Parameter request: the request to complete
    static func created(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 201)
    }
    
    /// Complete the HTTP Request with a 202 - accepted
    /// - Parameter request: the request to complete
    static func accepted(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 202)
    }
    
    /// Complete the HTTP request with a 203 - Non Authoritative Information
    /// - Parameter request: the request to complete
    static func nonAuthoritativeInfo(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 203)
    }
    
    /// Complete the HTTP request with a 204 - No Content
    /// - Parameter request: the request to complete
    static func noContent(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 204)
    }
    
    /// Complete the HTTP Request with error 400 - bad request
    /// - Parameter request: the request to complete
    static func badRequest(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 400)
    }
    
    /// Complete the HTTP Request with error 401 - Unauthorized
    /// - Parameter request: the requst to Complete
    static func unauthorized(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 401)
    }
    
    /// Complete the HTTP request with error 402 - Payment Required
    /// - Parameter request: the request to complete
    static func paymentRequired(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 402)
    }
    
    /// Complete the HTTP request with error 403 - forbidden
    /// - Parameter request: the request to complete.
    static func forbidden(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 403)
    }
    
    /// Complete the HTTP request with error 404 - Not Found
    /// - Parameter request: the request to complete.
    static func notFound(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 404)
    }
    
    /// Complete the HTTP request with error 405 - Method Not Allowed
    /// - Parameter request: the request to complete
    static func methodNotAllowed(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 405)
    }
    
    /// Complete the HTTP request with error 406 - Proxy Authentication Required
    /// - Parameter request: the request to complete
    static func poxyAuthRequired(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 406)
    }
    
    /// Complete the HTTP request with error 407 - Not Accessible
    /// - Parameter request: the request to complete
    static func notAccessible(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 407)
    }
    
    /// Complete the HTTP Request with error 408 - Request Timeout
    /// - Parameter request: the request to complete
    static func requestTimeout(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 408)
    }
    
    /// Complete the HTTP REquest with error 423 - Locked
    /// - Parameter request: the request to complete
    static func locked(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 423)
    }
    
    // MARK: HTTP 500 Series Errors
    
    /// Complete the HTTP Request with error 500 - Internal Server Error
    /// - Parameter request: the request to complete.
    static func internalServerError(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 500)
    }
    
    /// Complete the HTTP request with error 501 - Not Implemented
    /// - Parameter request: the request to complete
    static func notImplemented(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 501)
    }
    
    /// Complete the HTTP request with error 502 - Bad Gateway
    /// - Parameter request: the request to complete
    static func badGateway(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 502)
    }
    
    /// Complete the HTTP Request with error 503 - Servcie Unavailable
    /// - Parameter request: the request to complete
    static func serviceUnavailable(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 503)
    }
    
    /// Complete the HTTP request with error 504 - Gateway Timeout
    /// - Parameter request: the request to complete
    static func gatewayTimeour(request: HTTPRequest) {
        completeRequest(request: request, statusCode: 504)
    }
    
    // MARK: Route Completion Handler
    
    /// Complete the HTTP Request
    /// - Parameters:
    ///     - request: The HTTP request to complete
    ///     - data: Data to provide in the body (e.g data encoded JSON)
    ///     - statusCode: The HTTP status code for the response
    ///     - contentType: The HTTP content type of the response (e.g. "text/html", "application/json", etc)
    static func completeRequest(request: HTTPRequest,
                                data: Data = Data(),
                                statusCode: Int = 200,
                                contentType: String = "text/html",
                                nsErrorCode: Int? = nil) {
        
        let headers: [String: String] = [
            "Content-Type": contentType,
            "Content-Length": data.count.description,
            "Server": "mockRESTServer"
        ]
        
        let response = HTTPURLResponse(url: request.urlRequest.url!,
                                       statusCode: statusCode,
                                       httpVersion: "HTTP/2",
                                       headerFields: headers)
        
        var nsError: NSError? = nil
        if let code = nsErrorCode {
            nsError = NSError(domain: "mock-error", code: code, userInfo: nil)
        }
        
        request.append(data: data)
        request.didComplete(response: response, error: nsError)
    }
    
}

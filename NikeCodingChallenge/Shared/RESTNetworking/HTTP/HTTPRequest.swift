//
//  HTTPRequest.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/13/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

open class HTTPRequest {
    
    public let urlRequest: URLRequest
    
    public let provider: HTTPProviderProtocol
    
    private var dataBuffer = Data()
    
    public var expectedContentSize: Int?
    
    private var responseDataTemp: (HTTPURLResponse?, Data, HTTPError?)?
    
    private var responseJSONTemp: (HTTPResponse<Any>)?
    
    private var onDownloadProgress: ((_ receivedSize: Int, _ expectedSize: Int) -> Void)?
    
    private var onUploadProgress: ((_ sentBytes: Int64, _ totalBytes: Int64) -> Void)?
    
    private var onCompleteData: ((HTTPURLResponse?, Data, HTTPError?) -> Void)?
    
    private var onCompleteJSON: ((HTTPResponse<Any>) -> Void)?
    
    init(urlRequest: URLRequest, provider: HTTPProviderProtocol) {
        self.urlRequest = urlRequest
        self.provider = provider
    }
    
    func append(data: Data) {
        self.dataBuffer.append(data)
        
        guard self.expectedContentSize == nil && self.expectedContentSize ?? 0 < 0 else { return }
        
        self.onDownloadProgress?(dataBuffer.count, expectedContentSize!)
        
    }
    
    func setUploadProgress(bytesSent: Int64, bytesToSend: Int64) {
        self.onUploadProgress?(bytesSent, bytesToSend)
    }
    
    func didComplete(response: URLResponse?, error: Error?) {
        var error = error
        
        let httpResponse = response as? HTTPURLResponse
        
        if let nsError = error as NSError? {
            switch nsError.code {
            case NSURLErrorCannotFindHost:
                onCompleteData?(httpResponse, dataBuffer, HTTPError.couldNotFindHost)
                return
            case NSURLErrorNotConnectedToInternet:
                onCompleteData?(httpResponse, dataBuffer, HTTPError.noInternetConnection)
            default:
                break
            }
        }
        
        if error == nil && httpResponse == nil {
            error = (response != nil) ? HTTPError.unknown("Failed to cast response as a HTTPURLRequest") : HTTPError.unknown("Missing response and error")
        }
        
        let validateError = provider.validate(response: httpResponse, data: dataBuffer, error: error)
        
        if let err = validateError {
            if provider.shouldContinue(with: err) {
                onCompleteData?(httpResponse, dataBuffer, validateError)
            }
            return
        }
        
        onCompleteData?(httpResponse, dataBuffer, validateError)
        
        var responseToReturn: HTTPResponse<Any>
        
        guard dataBuffer.count != 0 else {
            responseToReturn = HTTPResponse(response: httpResponse, data: dataBuffer, result: .failure(.unknown("Response recieved from the server is empty")))
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: dataBuffer as Data, options: JSONSerialization.ReadingOptions.allowFragments)
            responseToReturn = HTTPResponse(response: httpResponse, data: dataBuffer, result: .success(json))
            
        } catch {
            responseToReturn = HTTPResponse(response: httpResponse, data: dataBuffer, result: HTTPResult.failure(HTTPError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error))))
        }
        
        onCompleteJSON?(responseToReturn)
    }
    
    @discardableResult
    open func response(_ handler: @escaping (HTTPURLResponse?, Data, HTTPError?) -> Void) -> Self {
        self.onCompleteData = handler
        
        if let response = responseDataTemp {
            handler(response.0, response.1, response.2)
        }
        return self
    }
    
    @discardableResult
    open func responseJSON(_ handler: @escaping ((HTTPResponse<Any>) -> Void)) -> Self {
        self.onCompleteJSON = handler
        
        if let response = responseJSONTemp {
            handler(response)
        }
        return self
    }
}

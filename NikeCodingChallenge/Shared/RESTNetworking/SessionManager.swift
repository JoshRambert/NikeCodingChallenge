//
//  SessionManager.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 9/12/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public protocol SessionManagerDelegate: URLSessionDataDelegate {
    
    var requests: [URLSessionTask: HTTPRequest] { get set }
    
}

class SessionManager: NSObject, SessionManagerDelegate {
    
    static let `default` = SessionManager()
    
    var requests: [URLSessionTask : HTTPRequest] = [URLSessionTask : HTTPRequest]()
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let request = requests[task] else { return }
        
        request.setUploadProgress(bytesSent: totalBytesSent, bytesToSend: totalBytesExpectedToSend)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let request = requests[dataTask] else { return }
        
        request.append(data: data)
    }
    
    func urlSession(_ urlSession: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let request = requests[dataTask] else { return }
        
        request.expectedContentSize = Int(response.expectedContentLength)
        completionHandler(Foundation.URLSession.ResponseDisposition.allow)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let request = requests.removeValue(forKey: task) else { return }
        
        request.didComplete(response: task.response, error: error)
    }
}

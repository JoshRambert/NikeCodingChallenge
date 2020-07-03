//
//  Strings+Helper.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/2/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

extension String {
    
    var encoded: String {
        get {
            return Data(self.utf8).base64EncodedString()
        }
        
    }
    
    var decoded: String {
        get {
            guard let data = Data(base64Encoded: self) else { return self }
            
            return String(data: data, encoding: .utf8) ?? ""
        }
        
    }
    
}

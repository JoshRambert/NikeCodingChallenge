//
//  Genres.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/3/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

struct Genre {
    
    struct Keys {
        static let genreId = "genreId"
        static let name = "name"
        static let url = "url"
    }
    
    init(dictionary: [String: Any]) {
        
        self.genreId = dictionary[Keys.genreId] as? String
        self.name = dictionary[Keys.name] as? String
        self.url = dictionary[Keys.url] as? String
    }
    
    let genreId: String?
    let name: String?
    let url: String?
}

//
//  Song.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/2/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

struct Album {
    
    struct Keys {
        static let name = "name"
        static let artistName = "artistName"
        static let albumArt = "artworkUrl100"
        static let releaseDate = "releaseDate"
        static let genres = "genres"
        static let copyrightInfo = "copyright"
        static let url = "url"
    }
    
    init(dictionary: [String: Any]) {
        self.name = dictionary[Keys.name] as? String
        self.artistName = dictionary[Keys.artistName] as? String
        self.albumArt = dictionary[Keys.albumArt] as? String
        self.releaseDate = dictionary[Keys.releaseDate] as? String
        self.url = dictionary[Keys.url] as? String
        
        self.genre = Genre(dictionary: (dictionary[Keys.genres] as? [[String: Any]])?.first ?? [:])
    }
    
    let name: String?
    let artistName: String?
    let albumArt: String?
    let releaseDate: String?
    let genre: Genre?
    let url: String?
}

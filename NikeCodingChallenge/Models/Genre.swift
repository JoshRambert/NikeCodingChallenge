//
//  Genres.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/3/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

struct Genre: Codable {
    
    let genreId: String
    let name: String
    let url: String
    
    public enum CodingKeys: String, CodingKey {
        case genreId
        case name
        case url
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        genreId = try values.decode(String.self, forKey: .genreId)
        name = try values.decode(String.self, forKey: .name)
        url = try values.decode(String.self, forKey: .url)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genreId, forKey: .genreId)
        try container.encode(name, forKey: .name)
        try container.encode(url, forKey: .url)
    }
    
    init(genreId: String,
         name: String,
         url: String) {
        
        self.genreId = genreId
        self.name = name
        self.url = url
    }
}

struct Genres: Codable {
    
    let genres: [Genre]
    
    public enum CodingKeys: String, CodingKey {
        case genres
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        genres = try values.decode(Array<Genre>.self, forKey: .genres)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genres, forKey: .genres)
    }
    
    public var first: Genre? {
        
        guard !self.genres.isEmpty else {
            return nil
        }
        
        return self.genres.first!
    }
    
}

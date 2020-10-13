//
//  Song.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/2/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

public struct Album: Codable {
    
    var name: String
    var artistName: String
    var albumArt: String
    var releaseDate: String
    var genres: Genres
    var url: String
    var copyrightInfo: String
    
    public enum CodingKeys: String, CodingKey {
        case name
        case artistName
        case albumArt = "artworkUrl100"
        case releaseDate
        case genres
        case copyrightInfo = "copyright"
        case url
    }
    
    struct Keys {
        static let name = "name"
        static let artistName = "artistName"
        static let albumArt = "artworkUrl100"
        static let releaseDate = "releaseDate"
        static let genres = "genres"
        static let copyrightInfo = "copyright"
        static let url = "url"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        artistName = try values.decode(String.self, forKey: .artistName)
        albumArt = try values.decode(String.self, forKey: .albumArt)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        genres = try values.decode(Genres.self, forKey: .genres)
        copyrightInfo = try values.decode(String.self, forKey: .copyrightInfo)
        url = try values.decode(String.self, forKey: .url)
    }
    
    init(name: String,
         artistName: String,
         albumArt: String,
         releaseDate: String,
         url: String,
         copyright: String,
         genres: Genres) {
        
        self.name = name
        self.artistName = artistName
        self.albumArt = albumArt
        self.releaseDate = releaseDate
        self.url = url
        self.copyrightInfo = copyright
        self.genres = genres
    }

}

public struct Albums: Codable {
    
    let albums: [Album]
    
    public enum CodingKeys: String, CodingKey {
        case albums
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        albums = try values.decode(Array<Album>.self, forKey: .albums)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(albums, forKey: .albums)
    }
    
}

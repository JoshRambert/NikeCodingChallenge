//
//  NetworkService.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/2/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation

class NetworkService {
    
    struct Constant {
        static let iTunesUrl = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/25/explicit.json"
        static let feed = "feed"
        static let results = "results"
    }
    
    public var albums = [Album]()
    
    // Parse the data retrieved from the JSON content
    
    private func parse(jsonData: Data) {
        
        do {
            
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                let feed = json[Constant.feed] as? [String: Any],
                let results = feed[Constant.results] as? [[String: Any]] {
                
                for result in results {
                    
                    let album = Album(dictionary: result)
                    albums.append(album)
                    
                }
                
            }
            
        } catch let error as NSError {
            debugPrint("Failed to load: \(error.localizedDescription)")
        }
        
    }
    
    // Load the JSON Content from the chosen URL
    
    private func loadJSON(fromURlString urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        
        urlSession.resume()
    }
    
    // A non private function that can be accessed by the ViewControllers
    
    func retrieveTopAlbums() {
        
        self.loadJSON(fromURlString: Constant.iTunesUrl) { (result) in
            
            switch result {
            case .success(let data):
                self.parse(jsonData: data)
                
                // Trigger a notification that can be observed by the ViewControllers
                
                NotificationCenter.default.post(name: .retrievedAlbums, object: nil)

            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

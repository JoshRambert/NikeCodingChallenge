//
//  UIImageView+LoadImage.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/3/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation
import UIKit



extension UIImageView {
    
    static let imageCache = NSCache<NSString, UIImage>()
    
    // Load an image from a URL and save it to the cache -- if the image is already stored in cache, retrieve that image
    
    func loadImage(fromUrl url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                UIImageView.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                self.image = image
            }
        }.resume()
    }
}

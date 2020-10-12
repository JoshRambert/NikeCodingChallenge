//
//  HomeControllerCells.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/3/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation
import UIKit

class HomeControllerCells: UITableViewCell {
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    var artistNameLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = .lightGray
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        tl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        return tl
    }()
    
    var albumNameLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = .darkText
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        tl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        return tl
    }()
    
    var albumArt: UIImageView = {
        
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        
        return iv
    }()
    
    // MARK: - Handlers
    
    func setupCell() {
        
        self.addSubview(albumArt)
        
        albumArt.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        albumArt.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        self.addSubview(albumNameLabel)
        
        albumNameLabel.leftAnchor.constraint(equalTo: albumArt.rightAnchor, constant: 8).isActive = true
        albumNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 23).isActive = true
        albumNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        self.addSubview(artistNameLabel)
        
        artistNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -23).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: albumArt.rightAnchor, constant: 8).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
    }
    
    func getInfo(forAlbum album: Album) {
        
        artistNameLabel.text = album.artistName
        albumNameLabel.text = album.name
        
//        guard
//            let urlString = album.albumArt,
//            let url = URL(string: urlString) else { return }
        
        //albumArt.loadImage(fromUrl: url)
    }
    
    override var reuseIdentifier: String? {
        return "HomeCells"
    }
    
}

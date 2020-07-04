//
//  DetailsController.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/3/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var background: UIImageView = {
        let iv = UIImageView()
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        iv.addSubview(blurEffectView)
        blurEffectView.pin(to: iv)
        
        return iv
    }()
    
    var artistNameLabel: UILabel = {
        let tl = UILabel()
        tl.numberOfLines = 0
        tl.textColor = .white
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        tl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return tl
    }()
    
    var albumNameLabel: UILabel = {
        let tl = UILabel()
        tl.numberOfLines = 0
        tl.textColor = .white
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        tl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return tl
    }()
    
    var albumArt: UIImageView = {
        
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        
        return iv
    }()
    
    var albumGenreLabel: UILabel = {
        let tl = UILabel()
        tl.numberOfLines = 0
        tl.textColor = .white
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        tl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return tl
    }()
    
    var releaseDateLabel: UILabel = {
        let tl = UILabel()
        tl.numberOfLines = 0
        tl.textColor = .white
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        tl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return tl
    }()
    
    var copyRightLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = .white
        tl.numberOfLines = 1
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        tl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return tl
    }()
    
    var urlButton: UIButton = {
        
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        bt.setTitle("View Website", for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bt.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        return bt
    }()
    
    var album: Album?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    // MARK: - Handlers
    
    func setupView() {
    
        self.view.backgroundColor = .white
        
        // Add the properties to the view and set their constraints
    
        self.view.addSubview(background)
        
        background.pin(to: self.view)
                
        self.view.addSubview(albumArt)
        
        albumArt.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        albumArt.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        albumArt.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        albumArt.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        albumArt.frame.size.height = 300
        albumArt.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.view.addSubview(albumNameLabel)
        
        albumNameLabel.topAnchor.constraint(equalTo: albumArt.bottomAnchor, constant: 5).isActive = true
        albumNameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        albumNameLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        
        self.view.addSubview(artistNameLabel)
        
        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 5).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        
        self.view.addSubview(albumGenreLabel)
        
        albumGenreLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 5).isActive = true
        albumGenreLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        albumGenreLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        
        self.view.addSubview(releaseDateLabel)
        
        releaseDateLabel.topAnchor.constraint(equalTo: albumGenreLabel.bottomAnchor, constant: 5).isActive = true
        releaseDateLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        releaseDateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        
        self.view.addSubview(copyRightLabel)
        
        copyRightLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        copyRightLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        copyRightLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 10).isActive = true
        
        self.view.addSubview(urlButton)
        
        urlButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        urlButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        urlButton.addTarget(self, action: #selector(toWebsite), for: .touchDown)
        
        // NavigationBar setup
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupInfo(forAlbum album: Album) {
        
        guard
            let urlString = album.albumArt,
            let url = URL(string: urlString),
            let albumName = album.name,
            let artistName = album.artistName,
            let albumGenre = album.genre?.name,
            let releaseDate = album.releaseDate,
            let copyRight = album.copyrightInfo
            else { return }
            
        albumArt.loadImage(fromUrl: url)
        background.loadImage(fromUrl: url)
        albumNameLabel.text = "Name:\n\(albumName)"
        artistNameLabel.text = "Artist:\n\(artistName)"
        albumGenreLabel.text = "Genre:\n\(albumGenre)"
        releaseDateLabel.text = "Release Date:\n\(releaseDate)"
        copyRightLabel.text = copyRight
    }
    
    @objc func toWebsite() {
        
        guard
            let urlString = self.album?.url,
            let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url)
    }
    
}

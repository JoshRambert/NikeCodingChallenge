//
//  HomeController.swift
//  NikeCodingChallenge
//
//  Created by Joshua Rambert on 7/2/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation
import UIKit

class HomeController: UIViewController {
    
    // MARK: - Properties
    
    var delegate = AppDelegate()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        
        return tv
    }()

    // MARK: - Init
    
    // Remove the observers once the class has been deinitialized
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .retrievedAlbums, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hit the endpoint to retrieve the data for the tableView

        delegate.networkService.retrieveTopAlbums()

        setupView()
        registerObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Handlers
    
    func setupView() {
                
        view.addSubview(tableView)
        
        tableView.pin(to: self.view)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
        tableView.register(HomeControllerCells.self, forCellReuseIdentifier: "HomeCells")
        
        navigationController?.navigationBar.barTintColor = UIColor.opaqueSeparator.withAlphaComponent(0)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Top Albums on iTunes"
    }
    
    // Observe the notification for the album data
    
    func registerObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleReloadTable),
                                               name: .retrievedAlbums,
                                               object: nil)
    }
    
    @objc func handleReloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.networkService.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCells", for: indexPath) as! HomeControllerCells
        
        let album = delegate.networkService.albums[indexPath.row]
        
        cell.getInfo(forAlbum: album)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let album = delegate.networkService.albums[indexPath.row]
        
        let vc = DetailViewController()
        vc.album = album
        vc.setupInfo(forAlbum: album)
        navigationController?.pushViewController(vc, animated: true)
    }
}

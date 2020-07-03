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
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        
        return tv
    }()

    // MARK: - Init
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .retrievedAlbums, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        registerObservers()
    }
    
    // MARK: - Handlers
    
    func setupView() {
        delegate.networkService.retrieveTopAlbums()
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.register(HomeControllerCells.self, forCellReuseIdentifier: "HomeCells")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 70
        
        navigationController?.navigationBar.barTintColor = .opaqueSeparator
        navigationItem.title = "Top Albums on iTunes"
    }
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCells", for: indexPath) as! HomeControllerCells

        //Go to the details page
    }
}

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
        
        tableView.pin(to: self.view)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
        tableView.register(HomeControllerCells.self, forCellReuseIdentifier: "HomeCells")
        
        navigationController?.navigationBar.barTintColor = UIColor.opaqueSeparator.withAlphaComponent(0)
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
        tableView.deselectRow(at: indexPath, animated: true)
        
        let album = delegate.networkService.albums[indexPath.row]
        
        let vc = DetailViewController()
        vc.album = album
        vc.setupInfo(forAlbum: album)
        navigationController?.pushViewController(vc, animated: true)
        //Go to the details page
    }
}

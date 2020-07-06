//
//  WebView.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/4/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebView: UIViewController {
    
    // MARK: - Properties
    
    var webKit = WKWebView()
    var url: URL?
    
    var closeButton: UIButton = {
        
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        bt.setTitle("Close", for: .normal)
        bt.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        bt.setTitleColor(UIColor.black, for: .normal)
        bt.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bt.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        return bt
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    // MARK: Handlers
    
    func setupView() {
        self.view.addSubview(webKit)
        webKit.pin(to: self.view)
        
        guard let url = self.url else { return }
        
        let request = URLRequest(url: url)
        webKit.load(request)
        
        self.view.addSubview(closeButton)
        
        closeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

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
        
        print("YES")
    }
    
}

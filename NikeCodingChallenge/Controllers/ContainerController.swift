//
//  ContainerController.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/2/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation
import UIKit

class ContainerController: UIViewController {
    
    // MARK: - Properties
    let delegate = AppDelegate()

    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHomeController()
    }
    
    // MARK: - Handlers
    
    func configureHomeController() {
        let homeController = HomeController()
        let controller = UINavigationController(rootViewController: homeController)
        
        view.addSubview(controller.view)
        addChild(controller)
        controller.didMove(toParent: self)
    }
    
}


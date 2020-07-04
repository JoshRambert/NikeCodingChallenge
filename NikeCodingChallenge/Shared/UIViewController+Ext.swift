//
//  UIViewController+Ext.swift
//  NikeCodingChallenge
//
//  Created by Joshua  Rambert on 7/4/20.
//  Copyright © 2020 Joshua Rambert. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    // Force a page sheet presentation style
    
    func presentPageSheet(_ viewController: UIViewController, animated: Bool = true) {
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .pageSheet
        self.present(viewController, animated: animated, completion: nil)
    }
    
}

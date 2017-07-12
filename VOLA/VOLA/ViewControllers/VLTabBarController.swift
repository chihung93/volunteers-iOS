//
//  VLTabBarController.swift
//  VOLA
//
//  Created by Connie Nguyen on 6/10/17.
//  Copyright © 2017 Systers-Opensource. All rights reserved.
//

import UIKit

/// Tab bar controller for main navigation of the app
class VLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        selectedIndex = 1       // Set "Home" as default
    }
}

//
//  TabBarViewController.swift
//  demoApp
//
//  Created by ATPL on 8/1/16.
//  Copyright © 2016 ATPL. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
self.navigationItem.hidesBackButton = true
        self.title = "Chat"
        self.tabBar.barStyle = .Black
        self.tabBar.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

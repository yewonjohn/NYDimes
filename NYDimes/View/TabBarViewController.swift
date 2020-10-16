//
//  TabBarViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/15/20.
//

import UIKit

class TabBarViewController: UITabBarController{
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

//
//  TabBarViewController.swift
//  NYDimes
//
//  Created by John Kim on 10/15/20.
//

import UIKit

class TabBarViewController: UITabBarController{
    
    //MARK:- LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        selectedIndex = 1

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

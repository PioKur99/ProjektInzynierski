//
//  TabBarViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 28/06/2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var firstLoad: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(firstLoad == true) {self.selectedIndex = 1}
        else {self.selectedIndex = 0}
        
        
    }
    
        
}


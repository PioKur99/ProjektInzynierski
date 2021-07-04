//
//  TabBarViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 28/06/2021.
//

import UIKit
import FirebaseDatabase

class TabBarViewController: UITabBarController {
    
    //let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let testObj: [String: String] = [
            "name" : "Piotr",
            "lastName": "K"
        ]
        DB.child("Test").setValue(testObj)*/
        self.selectedIndex = 1
    }
    
        
}


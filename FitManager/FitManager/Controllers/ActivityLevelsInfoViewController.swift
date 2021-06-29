//
//  ActivityLevelsInfoViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 29/06/2021.
//

import UIKit

class ActivityLevelsInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToData(_ sender: Any) {
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toMyData") {
            let dest = segue.destination as! TabBarViewController
            dest.firstLoad = false
        }
    }
    

}

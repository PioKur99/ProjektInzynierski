//
//  ProductsViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 28/06/2021.
//

import UIKit
import FirebaseDatabase

class ProductsViewController: UIViewController {
    
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        DB.child("Products").observeSingleEvent(of: .value, with: {snapshot in
            let val = snapshot.value
            print(val!)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DB.child("Products").observeSingleEvent(of: .value, with: {snapshot in
            let val = snapshot.value
            print(val!)
        })
    }
    

    @IBAction func goToAddNewProduct(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "NewProductViewController")
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
}

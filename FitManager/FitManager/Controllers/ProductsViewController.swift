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
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        products = []
        DB.child("Products").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.products.append(newProduct)
                newProduct.printProd()
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    

    @IBAction func goToAddNewProduct(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "NewProductViewController")
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
}

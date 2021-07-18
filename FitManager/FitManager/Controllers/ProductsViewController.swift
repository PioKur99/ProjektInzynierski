//
//  ProductsViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 28/06/2021.
//

import UIKit
import FirebaseDatabase

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var productsTable: UITableView!
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsTable.dataSource = self
        productsTable.delegate = self
        initTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initTable()
        
    }
    

    @IBAction func goToAddNewProduct(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "NewProductViewController")
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    func initTable() {
        products.removeAll()
        DB.child("Products").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.products.append(newProduct)
            }
        })
        //Need to wait due to asynchronus data fetching
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.04) {
            self.productsTable.reloadData()
        }
    }
}


extension ProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productsTable.deselectRow(at: indexPath, animated: true)
        let product = products[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        VC.product = product
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

extension ProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.products[indexPath.row].name
        return cell
    }
}

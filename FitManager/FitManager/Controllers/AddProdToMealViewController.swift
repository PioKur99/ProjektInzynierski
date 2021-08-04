//
//  AddProdToMealViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 02/08/2021.
//

import UIKit
import Firebase

class AddProdToMealViewController: UIViewController {

    @IBOutlet weak var productsTable: UITableView!
    @IBOutlet weak var productsSearchBar: UISearchBar!
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    var products: [Product] = []
    var currentProducts: [Product] = []
    var whichMeal = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        productsTable.dataSource = self
        productsTable.delegate = self
        productsSearchBar.delegate = self
        initTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initTable()
    }
    
    func initTable() {
        products.removeAll()
        DB.child("Products").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.products.append(newProduct)
                self.currentProducts.append(newProduct)
                self.productsTable.reloadData()
            }
        })
    }
}

extension AddProdToMealViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            currentProducts = products
            productsTable.reloadData()
            return
        }
        
        currentProducts = products.filter({ product -> Bool in
            guard let text = searchBar.text else {return false}
            return product.name.contains(text)
        })
        productsTable.reloadData()
    }
}

extension AddProdToMealViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productsTable.deselectRow(at: indexPath, animated: true)
        let product = currentProducts[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "ProdToMealViewController") as! ProdToMealViewController
        VC.whichMeal = whichMeal
        VC.product = product
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}

extension AddProdToMealViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.currentProducts[indexPath.row].name
        return cell
    }
}

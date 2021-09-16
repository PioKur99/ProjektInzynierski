//
//  ProductsViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 28/06/2021.
//

import UIKit
import FirebaseDatabase

class ProductsViewController: UIViewController{
    
    @IBOutlet weak var productsTable: UITableView!
    @IBOutlet weak var productSearchBar: UISearchBar!
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    var products: [Product] = []
    var currentProducts: [Product] = []

    @IBOutlet weak var cellKcal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsTable.dataSource = self
        productsTable.delegate = self
        productSearchBar.delegate = self
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
                self.currentProducts.append(newProduct)
                self.productsTable.reloadData()
            }
        })
    }
}

extension ProductsViewController: UISearchBarDelegate {
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

extension ProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productsTable.deselectRow(at: indexPath, animated: true)
        let product = currentProducts[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        VC.product = product
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            productsTable.beginUpdates()
            let toDelete = self.currentProducts[indexPath.row].location!
            print(toDelete)
            DB.child("Products/\(toDelete)").setValue(nil)
            self.currentProducts.remove(at: indexPath.row)
            productsTable.deleteRows(at: [indexPath], with: .fade)
            products = currentProducts
            productsTable.endUpdates()
        }
    }
}

extension ProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.currentProducts[indexPath.row].name
        return cell
    }
    
}

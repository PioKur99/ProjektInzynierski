//
//  NewProductViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 04/07/2021.
//

import UIKit
import FirebaseDatabase

class NewProductViewController: UIViewController {
    
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    var productID: Int = 0
    var products: [Product] = []
    var canSave = true

    @IBOutlet weak var productNameInput: UITextField!
    @IBOutlet weak var productManufacturerInput: UITextField!
    @IBOutlet weak var caloriesInput: UITextField!
    @IBOutlet weak var carbsInput: UITextField!
    @IBOutlet weak var proteinInput: UITextField!
    @IBOutlet weak var fatsInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProducts()
        self.hideKeyboardWhenTappedAround()
        let tempID = UserDefaults.standard.object(forKey: "ProductID")
        if let ID = tempID as? Int {
            productID = ID
        }
    }
    
    func getProducts() {
        products.removeAll()
        DB.child("Products").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.products.append(newProduct)
            }
        })
    }
    
    func productAlreadyExistsAlert() {
        let alert = UIAlertController(title: "Nie udało się dodać produktu", message: "Produkt o podanej nazwie i producencie już istnieje!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Zamknij", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
        
        productNameInput.text = ""
        productManufacturerInput.text = ""
        caloriesInput.text = ""
        carbsInput.text = ""
        proteinInput.text = ""
        fatsInput.text = ""
    }
    func missingDataAlert() {
        let alert = UIAlertController(title: "Nie udało się dodać produktu", message: "Upewnij się, że wszystkie pola posiadają wartość.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Zamknij", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func succesAlert() {
        let alert = UIAlertController(title: "Produkt został dodany pomyślnie",message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Zamknij", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
        
        productNameInput.text = ""
        productManufacturerInput.text = ""
        caloriesInput.text = ""
        carbsInput.text = ""
        proteinInput.text = ""
        fatsInput.text = ""
    }
    
    @IBAction func addNewProduct(_ sender: Any) {
        canSave = true
        if(productNameInput.text != "" && productManufacturerInput.text != "" &&
            caloriesInput.text != "" && carbsInput.text != "" && proteinInput.text != "" && fatsInput.text != "") {
            
            for prod in products {
                if (prod.name == productNameInput.text && prod.manufacturer == productManufacturerInput.text){
                    canSave = false
                    productAlreadyExistsAlert()
                }
            }
            
            
            if(canSave) {
            DB.child("Products/\(productID)").setValue(["name": productNameInput.text!,
                                              "manufacturer": productManufacturerInput.text!,
                                              "kcalPer100g": Double(caloriesInput.text!)!,
                                              "carbsPer100g": Double(carbsInput.text!)!,
                                              "proteinPer100g": Double(proteinInput.text!)!,
                                              "fatsPer100g": Double(fatsInput.text!)!
            ])
            
            productID += 1
            UserDefaults.standard.setValue(productID, forKey: "ProductID")
            succesAlert()
            }
            
        }
        
        else {
            missingDataAlert()
        }
    }
    
}



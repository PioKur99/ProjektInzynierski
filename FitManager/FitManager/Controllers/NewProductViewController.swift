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

    @IBOutlet weak var productNameInput: UITextField!
    @IBOutlet weak var productManufacturerInput: UITextField!
    @IBOutlet weak var caloriesInput: UITextField!
    @IBOutlet weak var carbsInput: UITextField!
    @IBOutlet weak var proteinInput: UITextField!
    @IBOutlet weak var fatsInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        let tempID = UserDefaults.standard.object(forKey: "ProductID")
        if let ID = tempID as? Int {
            productID = ID
        }
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
        if(productNameInput.text != "" && productManufacturerInput.text != "" &&
            caloriesInput.text != "" && carbsInput.text != "" && proteinInput.text != "" && fatsInput.text != "") {
            
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
        
        else {
            missingDataAlert()
        }
    }
    
}



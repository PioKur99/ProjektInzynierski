//
//  ProdToMealViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 02/08/2021.
//

import UIKit
import Firebase

class ProdToMealViewController: UIViewController {
    var whichMeal = ""
    var productID: Int = 0
    var product = Product()
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()

    @IBOutlet weak var prodNameLabel: UILabel!
    @IBOutlet weak var prodManuLabel: UILabel!
    @IBOutlet weak var prodCaloriesLabel: UILabel!
    @IBOutlet weak var prodCarbsLabel: UILabel!
    @IBOutlet weak var prodProteinsLabel: UILabel!
    @IBOutlet weak var prodFatLabel: UILabel!
    @IBOutlet weak var prodQuantityInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        prodFatLabel.text = String(product.fatsPer100g)
        prodProteinsLabel.text = String(product.proteinsPer100g)
        prodCarbsLabel.text = String(product.carbsPer100g)
        prodCaloriesLabel.text = String(product.kcalPer100g)
        prodNameLabel.text = product.name
        prodManuLabel.text = product.manufacturer
        let tempID = UserDefaults.standard.object(forKey: "ProductID")
        if let ID = tempID as? Int {
            productID = ID
        }

    }
    
    @IBAction func addProductButton(_ sender: Any) {
        if(prodQuantityInput.text != "" && prodQuantityInput.text != "0") {
            let quantity = Double(prodQuantityInput.text!)
            product.weight = quantity
            
            DB.child(whichMeal + "\(productID)").setValue(["name": product.name,
                                          "manufacturer": product.manufacturer,
                                          "kcalPer100g": product.kcalPer100g,
                                          "carbsPer100g": product.carbsPer100g,
                                          "proteinPer100g": product.proteinsPer100g,
                                          "fatsPer100g": product.fatsPer100g,
                                          "quantity": product.weight!
            ])
            productID += 1
            UserDefaults.standard.setValue(productID, forKey: "ProductID")
            succesAlert()
        }
        else {
            missingDataAlert()
        }
    }
    
    func missingDataAlert() {
        let alert = UIAlertController(title: "Nie udało się dodać produktu", message: "Upewnij się, że gramatura produktu posiada niezerową wartość.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Zamknij", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func succesAlert() {
        let alert = UIAlertController(title: "Produkt został dodany pomyślnie",message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Zamknij", style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(action)
        present(alert, animated: true)
        
    }
}

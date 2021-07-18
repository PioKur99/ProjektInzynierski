//
//  ProductDetailsViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 18/07/2021.
//

import UIKit
import Firebase

class ProductDetailsViewController: UIViewController {
    
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    var product: Product = Product()
    
    @IBOutlet weak var productFatLabel: UILabel!
    @IBOutlet weak var productProteinLabel: UILabel!
    @IBOutlet weak var productCarbsLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCaloriesLabel: UILabel!
    @IBOutlet weak var productManuLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var productFatInput: UITextField!
    @IBOutlet weak var productProteinInput: UITextField!
    @IBOutlet weak var productCarbsInput: UITextField!
    @IBOutlet weak var productCaloriesInput: UITextField!
    @IBOutlet weak var productNameInput: UITextField!
    @IBOutlet weak var productManuInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        goToDisplayMode()
    }
    
    @IBAction func editButtonPress(_ sender: Any) {
        goToEditMode()
    }
    @IBAction func saveButtonPress(_ sender: Any) {
        
        if(productNameInput.text != "" && productManuInput.text != "" &&
            productCaloriesInput.text != "" && productCarbsInput.text != "" && productProteinInput.text != "" && productFatInput.text != "") {
        let index = product.location!
        DB.child("Products/\(index)").updateChildValues(["name": productNameInput.text!,
                                                "manufacturer": productManuInput.text!,
                                                "kcalPer100g": Double(productCaloriesInput.text!)!,
                                                "carbsPer100g": Double(productCarbsInput.text!)!,
                                                "proteinPer100g": Double(productProteinInput.text!)!,
                                                "fatsPer100g": Double(productFatInput.text!)!
              ])
        self.product.update(iName: productNameInput.text!, iManu: productManuInput.text!, iKcal: Double(productCaloriesInput.text!)!, iCarbs: Double(productCarbsInput.text!)!, iProtein: Double(productProteinInput.text!)!, iFats: Double(productFatInput.text!)!)
        self.product.printProd()
        succesAlert()
        goToDisplayMode()
        }
        
        else {
            missingDataAlert()
        }
        
        
    }
    
    func goToEditMode() {
        productFatInput.isHidden = false
        productProteinInput.isHidden = false
        productCarbsInput.isHidden = false
        productCaloriesInput.isHidden = false
        productNameInput.isHidden = false
        productManuInput.isHidden = false
        
        editButton.isHidden = true
        saveButton.isHidden = false
        
        productFatLabel.isHidden = true
        productProteinLabel.isHidden = true
        productCarbsLabel.isHidden = true
        productCaloriesLabel.isHidden = true
        productNameLabel.isHidden = true
        productManuLabel.isHidden = true
        
        productFatInput.placeholder = String(product.fatsPer100g)
        productProteinInput.placeholder = String(product.proteinsPer100g)
        productCarbsInput.placeholder = String(product.carbsPer100g)
        productCaloriesInput.placeholder = String(product.kcalPer100g)
        productNameInput.placeholder = product.name
        productManuInput.placeholder = product.manufacturer
    }
    
    func goToDisplayMode() {
        productFatInput.isHidden = true
        productProteinInput.isHidden = true
        productCarbsInput.isHidden = true
        productCaloriesInput.isHidden = true
        productNameInput.isHidden = true
        productManuInput.isHidden = true
        
        saveButton.isHidden = true
        editButton.isHidden = false
        
        productFatLabel.isHidden = false
        productProteinLabel.isHidden = false
        productCarbsLabel.isHidden = false
        productCaloriesLabel.isHidden = false
        productNameLabel.isHidden = false
        productManuLabel.isHidden = false
        
        productFatLabel.text = String(product.fatsPer100g)
        productProteinLabel.text = String(product.proteinsPer100g)
        productCarbsLabel.text = String(product.carbsPer100g)
        productCaloriesLabel.text = String(product.kcalPer100g)
        productNameLabel.text = product.name
        productManuLabel.text = product.manufacturer
        
        productFatInput.text = String(product.fatsPer100g)
        productProteinInput.text = String(product.proteinsPer100g)
        productCarbsInput.text = String(product.carbsPer100g)
        productCaloriesInput.text = String(product.kcalPer100g)
        productNameInput.text = product.name
        productManuInput.text = product.manufacturer
        
    }
    
    func succesAlert() {
        let alert = UIAlertController(title: "Zmiany zostały wprowadzone pomyślnie",message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Zamknij", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func missingDataAlert() {
        let alert = UIAlertController(title: "Nie udało się zaktualizować produktu", message: "Upewnij się, że wszystkie pola posiadają wartość.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Zamknij", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

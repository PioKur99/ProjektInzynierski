//
//  MyDataViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 28/06/2021.
//

// To do: Zapisywanie danych po restarcie apki
import UIKit

class MyDataViewController: UIViewController {
    
    var genders = ["Mezczyzna", "Kobieta"]
    var activityLevel = ["Brak aktywnosci", "Niska aktywnosc", "Srednia aktywnosc", "Wysoka aktywnosc", "Bardzo wysoka aktywnosc"]
    var goals = ["Utrata wagi", "Utrzymanie wagi", "Przybranie wagi"]
    var genderSelect = "Mezczyzna"
    var activityLevelSelect = "Brak aktywnosci"
    var goalsSelect = "Utrata wagi"
    
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var activityLevelPicker: UIPickerView!
    @IBOutlet weak var goalPicker: UIPickerView!
    
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var weightInput: UITextField!
    
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    
    @IBOutlet weak var caloriesLabelValue: UILabel!
    @IBOutlet weak var proteinLabelValue: UILabel!
    @IBOutlet weak var carbsLabelValue: UILabel!
    @IBOutlet weak var fatsLabelValue: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        activityLevelPicker.delegate = self
        activityLevelPicker.dataSource = self
        goalPicker.delegate = self
        goalPicker.dataSource = self
        
        caloriesLabel.isHidden = true
        proteinLabel.isHidden = true
        carbsLabel.isHidden = true
        fatsLabel.isHidden = true
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func getActivityMultiplier() -> Double {
        if(activityLevelSelect == "Brak aktywnosci"){
            return 1.2
        }
        
        else if (activityLevelSelect == "Niska aktywnosc"){
            return 1.3
        }
        
        else if (activityLevelSelect == "Srednia aktywnosc"){
            return 1.45
        }
        
        else if (activityLevelSelect == "Wysoka aktywnosc"){
            return 1.6
        }
        
        else {return 1.85}
        
    }
    
    func calculateBMR() -> Double {
        var BMR = 0.0
        let age = Double(ageInput.text!)
        let height = Double(heightInput.text!)
        let weight = Double(weightInput.text!)
        let activityMultiplier = getActivityMultiplier()
        
        if(genderSelect == "Mezczyzna") {
            BMR = ((9.99 * weight!) + (6.25 * height!) - (4.92 * age!) + 5) * activityMultiplier
        }
        else {
            BMR = ((9.99 * weight!) + (6.25 * height!) - (4.92 * age!) - 161) * activityMultiplier
        }
        
        if(goalsSelect == "Utrata wagi") {return BMR - 150.0}
        else if(goalsSelect == "Przybranie wagi") {return BMR + 150.0}
        else {return BMR}
        
    }
    @IBAction func calculateBMRClick(_ sender: Any) {
        if(ageInput.text != "" && heightInput.text != "" && weightInput.text != "") {
            let BMR = calculateBMR()
            let proteins = Int((0.25 * BMR) / 4)
            let fats = Int((0.25 * BMR) / 9)
            let carbs = Int((0.6 * BMR) / 4)
            
            caloriesLabel.isHidden = false
            proteinLabel.isHidden = false
            carbsLabel.isHidden = false
            fatsLabel.isHidden = false
            
            caloriesLabelValue.text = String(Int(BMR))
            proteinLabelValue.text = String(proteins)
            carbsLabelValue.text = String(carbs)
            fatsLabelValue.text = String(fats)
            
        }
    }
    
}

extension MyDataViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return genders.count
        }
        
        else if pickerView.tag == 2 {
            return activityLevel.count
        }
        
        else {
            return goals.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return genders[row]
        }
        
        else if pickerView.tag == 2 {
            return activityLevel[row]
        }
        
        else {
            return goals[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            genderSelect = genders[row]
        }
        
        else if pickerView.tag == 2 {
            activityLevelSelect = activityLevel[row]
        }
        
        else {
            goalsSelect = goals[row]
        }
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

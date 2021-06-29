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
        
        caloriesLabel.isHidden = true
        proteinLabel.isHidden  = true
        carbsLabel.isHidden    = true
        fatsLabel.isHidden     = true
        
        genderPicker.delegate          = self
        genderPicker.dataSource        = self
        activityLevelPicker.delegate   = self
        activityLevelPicker.dataSource = self
        goalPicker.delegate            = self
        goalPicker.dataSource          = self
        
        let tempBMRStrings = UserDefaults.standard.object(forKey: "BMRStrings")
        let tempBMRNums = UserDefaults.standard.object(forKey: "BMRNumbs")
        if let BMRStrings = tempBMRStrings as? NSArray, let BMRNums = tempBMRNums as? NSArray {
            
            let tmpCalories = convertAnyToString(word: BMRNums[7])
            let tmpProteins = convertAnyToString(word: BMRNums[3])
            let tmpCarbs    = convertAnyToString(word: BMRNums[4])
            let tmpFats     = convertAnyToString(word: BMRNums[5])
            let tmpGender   =             BMRStrings[0] as! String
            let tmpActivity =             BMRStrings[1] as! String
            let tmpGoal     =             BMRStrings[2] as! String
            
            caloriesLabel.isHidden = false
            proteinLabel.isHidden  = false
            carbsLabel.isHidden    = false
            fatsLabel.isHidden     = false
            
            ageInput.text           = "\(BMRNums[0])"
            heightInput.text        = "\(BMRNums[1])"
            weightInput.text        = "\(BMRNums[2])"
            caloriesLabelValue.text = tmpCalories
            proteinLabelValue.text  = tmpProteins
            carbsLabelValue.text    = tmpCarbs
            fatsLabelValue.text     = tmpFats
            
            print(genders.firstIndex(of: tmpGender)!)
            print(activityLevel.firstIndex(of: tmpActivity)!)
            print(goals.firstIndex(of: tmpGoal)!)
            
            let genderIndex = genders.firstIndex(of: tmpGender)!
            let activityIndex = activityLevel.firstIndex(of: tmpActivity)!
            let goalIndex = goals.firstIndex(of: tmpGoal)!
            
            genderPicker.selectRow(genderIndex, inComponent: 0, animated: true)
            activityLevelPicker.selectRow(activityIndex, inComponent: 0, animated: true)
            goalPicker.selectRow(goalIndex, inComponent: 0, animated: true)
        }
        
        self.hideKeyboardWhenTappedAround()
        
    }
   
    @IBAction func calculateBMRClick(_ sender: Any) {
        if(ageInput.text != "" && heightInput.text != "" && weightInput.text != "") {
            
            let BMR = BMR(iAge: Double(ageInput.text!)!, iHeight: Double(heightInput.text!)!, iWeight: Double(weightInput.text!)!,
                          iGender: genderSelect, iActivityLevel: activityLevelSelect, iGoal: goalsSelect)
            BMR.setBMRValue()
            
            let BMRStringAttributes: [String] = [BMR.gender, BMR.activityLevel, BMR.goal]
            let BMRNumericAttributes: [Double] = [BMR.age, BMR.height, BMR.weight, BMR.proteinAmount, BMR.carbsAmount, BMR.fatsAmount, BMR.activityLevelMultiplier, BMR.BMRValue]
            
            UserDefaults.standard.setValue(BMRStringAttributes, forKey: "BMRStrings")
            UserDefaults.standard.setValue(BMRNumericAttributes, forKey: "BMRNumbs")
            
            caloriesLabel.isHidden = false
            proteinLabel.isHidden = false
            carbsLabel.isHidden = false
            fatsLabel.isHidden = false
            
            caloriesLabelValue.text = String(Int(BMR.BMRValue))
            proteinLabelValue.text = String(Int(BMR.proteinAmount))
            carbsLabelValue.text = String(Int(BMR.carbsAmount))
            fatsLabelValue.text = String(Int(BMR.fatsAmount))
            
        }
    }
    
    func convertAnyToString(word: Any) -> String {
        
        let doubleVal: Double = word as! Double
        let intVal = Int(doubleVal)
        let stringVal = "\(intVal)"
        return stringVal
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

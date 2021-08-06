//
//  MyMealsViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 28/06/2021.
//
/*
 D - Whole day
 B - Breakfast
 L - Lunch
 S - Supper
 K - Calories
 WW - Carbohydrates
 P - Protein
 F - Fat
 */

import UIKit
import Firebase

class MyMealsViewController: UIViewController {
    
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    var ID: Int = 0
    var breakfast = Meal()
    var lunch = Meal()
    var dinner = Meal()
    
    @IBOutlet weak var BK: UILabel!
    @IBOutlet weak var BF: UILabel!
    @IBOutlet weak var BP: UILabel!
    @IBOutlet weak var BWW: UILabel!
    
    @IBOutlet weak var LK: UILabel!
    @IBOutlet weak var LWW: UILabel!
    @IBOutlet weak var LF: UILabel!
    @IBOutlet weak var LP: UILabel!
    
    @IBOutlet weak var SK: UILabel!
    @IBOutlet weak var SWW: UILabel!
    @IBOutlet weak var SF: UILabel!
    @IBOutlet weak var SP: UILabel!
    
    @IBOutlet weak var DK: UILabel!
    @IBOutlet weak var DF: UILabel!
    @IBOutlet weak var DP: UILabel!
    @IBOutlet weak var DWW: UILabel!
    
    @IBOutlet weak var caloriesSlider: UISlider!
    @IBOutlet weak var carbsSlider: UISlider!
    @IBOutlet weak var proteinSlider: UISlider!
    @IBOutlet weak var fatSlider: UISlider!
    
    @IBOutlet weak var caloriesLimitLabel: UILabel!
    @IBOutlet weak var carbsLimitLabel: UILabel!
    @IBOutlet weak var proteinLimitLabel: UILabel!
    @IBOutlet weak var fatLimitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tempBMRNums = UserDefaults.standard.object(forKey: "BMRNumbs")
        if let BMRNums = tempBMRNums as? NSArray {
            let BMRValues = mapBMRValuesToStrings(inputArr: BMRNums)
            caloriesSlider.maximumValue = Float(BMRValues[7])!
            carbsSlider.maximumValue = Float(BMRValues[4])!
            proteinSlider.maximumValue = Float(BMRValues[3])!
            fatSlider.maximumValue = Float(BMRValues[5])!
            
            caloriesLimitLabel.text = BMRValues[7]
            carbsLimitLabel.text = BMRValues[4]
            proteinLimitLabel.text = BMRValues[3]
            fatLimitLabel.text = BMRValues[5]
            
        }
        let tempID = UserDefaults.standard.object(forKey: "ProductID")
        if let tmpID = tempID as? Int {
            ID = tmpID
        }
        updateMealsData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    @IBAction func newDayPress(_ sender: Any) {
        resetDayData()
        resetBreakfastData()
        resetLunchData()
        resetDinnerData()
    }
    
    
    @IBAction func navigateToBreakfast(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MealViewController") as! MealViewController
        resultViewController.whichMeal = "Breakfast"
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    @IBAction func navigateToLunch(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MealViewController") as! MealViewController
        resultViewController.whichMeal = "Lunch"
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    @IBAction func navigateToSupper(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MealViewController") as! MealViewController
        resultViewController.whichMeal = "Dinner"
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    func updateMealsData() {
        updateBreakfastData()
        updateLunchData()
        updateDinnerData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.updateDayData()
        }
    }
    
    func updateBreakfastData() {
        breakfast.products.removeAll()
        DB.child("Breakfast").observeSingleEvent(of: .value, with: {snapshot in
            if(!snapshot.hasChildren()) {
                self.BK.text = "0.0"
                self.BWW.text = "0.0"
                self.BP.text = "0.0"
                self.BF.text = "0.0"
            }
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.breakfast.products.append(newProduct)
                self.BK.text = String(self.breakfast.getCaloriesPerMeal())
                self.BWW.text = String(self.breakfast.getCarbsPerMeal())
                self.BP.text = String(self.breakfast.getProteinPerMeal())
                self.BF.text = String(self.breakfast.getFatsPerMeal())
            }
        })
    }
    
    func updateLunchData() {
        lunch.products.removeAll()
        DB.child("Lunch").observeSingleEvent(of: .value, with: {snapshot in
            if(!snapshot.hasChildren()) {
                self.LK.text = "0.0"
                self.LWW.text = "0.0"
                self.LP.text = "0.0"
                self.LF.text = "0.0"
            }
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.lunch.products.append(newProduct)
                self.LK.text = String(self.lunch.getCaloriesPerMeal())
                self.LWW.text = String(self.lunch.getCarbsPerMeal())
                self.LP.text = String(self.lunch.getProteinPerMeal())
                self.LF.text = String(self.lunch.getFatsPerMeal())
            }
        })
    }
    
    func updateDinnerData() {
        dinner.products.removeAll()
        DB.child("Dinner").observeSingleEvent(of: .value, with: {snapshot in
            if(!snapshot.hasChildren()) {
                self.SK.text = "0.0"
                self.SWW.text = "0.0"
                self.SP.text = "0.0"
                self.SF.text = "0.0"
            }
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.dinner.products.append(newProduct)
                self.SK.text = String(self.dinner.getCaloriesPerMeal())
                self.SWW.text = String(self.dinner.getCarbsPerMeal())
                self.SP.text = String(self.dinner.getProteinPerMeal())
                self.SF.text = String(self.dinner.getFatsPerMeal())
            }
        })
    }
    
    func updateDayData() {
        var DK = self.breakfast.getCaloriesPerMeal() + self.lunch.getCaloriesPerMeal() + self.dinner.getCaloriesPerMeal()
        var DWW = self.breakfast.getCarbsPerMeal() + self.lunch.getCarbsPerMeal() + self.dinner.getCarbsPerMeal()
        var DP = self.breakfast.getProteinPerMeal() + self.lunch.getProteinPerMeal() + self.dinner.getProteinPerMeal()
        var DF = self.breakfast.getFatsPerMeal() + self.lunch.getFatsPerMeal() + self.dinner.getFatsPerMeal()
        DK = round(10*DK)/10
        DWW = round(10*DWW)/10
        DP = round(10*DP)/10
        DF = round(10*DF)/10
        self.DK.text = String(DK)
        self.DWW.text = String(DWW)
        self.DP.text = String(DP)
        self.DF.text = String(DF)
        self.caloriesSlider.value = Float(DK)
        self.carbsSlider.value = Float(DWW)
        self.proteinSlider.value = Float(DP)
        self.fatSlider.value = Float(DF)
    }
    
    func resetBreakfastData() {
        DB.child("Breakfast").setValue(nil)
        breakfast.products.removeAll()
        self.BK.text = String(self.breakfast.getCaloriesPerMeal())
        self.BWW.text = String(self.breakfast.getCarbsPerMeal())
        self.BP.text = String(self.breakfast.getProteinPerMeal())
        self.BF.text = String(self.breakfast.getFatsPerMeal())
    }
    func resetLunchData() {
        DB.child("Lunch").setValue(nil)
        lunch.products.removeAll()
        self.LK.text = String(self.lunch.getCaloriesPerMeal())
        self.LWW.text = String(self.lunch.getCarbsPerMeal())
        self.LP.text = String(self.lunch.getProteinPerMeal())
        self.LF.text = String(self.lunch.getFatsPerMeal())
    }
    func resetDinnerData() {
        DB.child("Dinner").setValue(nil)
        dinner.products.removeAll()
        self.SK.text = String(self.dinner.getCaloriesPerMeal())
        self.SWW.text = String(self.dinner.getCarbsPerMeal())
        self.SP.text = String(self.dinner.getProteinPerMeal())
        self.SF.text = String(self.dinner.getFatsPerMeal())
    }
    func resetDayData() {
        var DK = self.breakfast.getCaloriesPerMeal() + self.lunch.getCaloriesPerMeal() + self.dinner.getCaloriesPerMeal()
        DK = round(10*DK)/10
        DB.child("History/\(ID)").setValue(["calories" : DK])
        ID += 1
        UserDefaults.standard.setValue(ID, forKey: "ProductID")
        self.DK.text = ""
        self.DWW.text = ""
        self.DP.text = ""
        self.DF.text = ""
        self.caloriesSlider.value = Float(0)
        self.carbsSlider.value = Float(0)
        self.proteinSlider.value = Float(0)
        self.fatSlider.value = Float(0)
    }
}

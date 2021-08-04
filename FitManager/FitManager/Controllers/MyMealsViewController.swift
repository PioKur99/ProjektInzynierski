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
    var breakfast = Meal()
    var lunch = Meal()
    var dinner = Meal()
    var caloriesSliderVal = 0.0
    var carbsSliderVal = 0.0
    var proteinSliderVal = 0.0
    var fatSliderVal = 0.0
    
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
        updateMealsData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
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
    }
    
    func updateBreakfastData() {
        breakfast.products.removeAll()
         caloriesSliderVal = 0.0
         carbsSliderVal = 0.0
         proteinSliderVal = 0.0
         fatSliderVal = 0.0
        DB.child("Breakfast").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.breakfast.products.append(newProduct)
                self.BK.text = String(self.breakfast.getCaloriesPerMeal())
                self.BWW.text = String(self.breakfast.getCarbsPerMeal())
                self.BP.text = String(self.breakfast.getProteinPerMeal())
                self.BF.text = String(self.breakfast.getFatsPerMeal())
                self.DK.text = String(self.breakfast.getCaloriesPerMeal())
                self.DWW.text = String(self.breakfast.getCarbsPerMeal())
                self.DP.text = String(self.breakfast.getProteinPerMeal())
                self.DF.text = String(self.breakfast.getFatsPerMeal())
                self.caloriesSliderVal = self.breakfast.getCaloriesPerMeal()
                self.carbsSliderVal = self.breakfast.getCarbsPerMeal()
                self.proteinSliderVal = self.breakfast.getProteinPerMeal()
                self.fatSliderVal = self.breakfast.getFatsPerMeal()
                self.caloriesSlider.value = Float(self.caloriesSliderVal)
                self.carbsSlider.value = Float(self.carbsSliderVal)
                self.proteinSlider.value = Float(self.proteinSliderVal)
                self.fatSlider.value = Float(self.fatSliderVal)
            }
        })
    }
    
    func updateLunchData() {
        lunch.products.removeAll()
         caloriesSliderVal = 0.0
         carbsSliderVal = 0.0
         proteinSliderVal = 0.0
         fatSliderVal = 0.0
        DB.child("Lunch").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.lunch.products.append(newProduct)
                self.LK.text = String(self.lunch.getCaloriesPerMeal())
                self.LWW.text = String(self.lunch.getCarbsPerMeal())
                self.LP.text = String(self.lunch.getProteinPerMeal())
                self.LF.text = String(self.lunch.getFatsPerMeal())
                self.DK.text = String(self.breakfast.getCaloriesPerMeal())
                self.DWW.text = String(self.breakfast.getCarbsPerMeal())
                self.DP.text = String(self.breakfast.getProteinPerMeal())
                self.DF.text = String(self.breakfast.getFatsPerMeal())
                self.caloriesSliderVal = self.breakfast.getCaloriesPerMeal()
                self.carbsSliderVal = self.breakfast.getCarbsPerMeal()
                self.proteinSliderVal = self.breakfast.getProteinPerMeal()
                self.fatSliderVal = self.breakfast.getFatsPerMeal()
                self.caloriesSlider.value = Float(self.caloriesSliderVal)
                self.carbsSlider.value = Float(self.carbsSliderVal)
                self.proteinSlider.value = Float(self.proteinSliderVal)
                self.fatSlider.value = Float(self.fatSliderVal)
            }
        })
    }
    
    func updateDinnerData() {
        dinner.products.removeAll()
         caloriesSliderVal = 0.0
         carbsSliderVal = 0.0
         proteinSliderVal = 0.0
         fatSliderVal = 0.0
        DB.child("Dinner").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.dinner.products.append(newProduct)
                self.SK.text = String(self.dinner.getCaloriesPerMeal())
                self.SWW.text = String(self.dinner.getCarbsPerMeal())
                self.SP.text = String(self.dinner.getProteinPerMeal())
                self.SF.text = String(self.dinner.getFatsPerMeal())
                self.DK.text = String(self.breakfast.getCaloriesPerMeal())
                self.DWW.text = String(self.breakfast.getCarbsPerMeal())
                self.DP.text = String(self.breakfast.getProteinPerMeal())
                self.DF.text = String(self.breakfast.getFatsPerMeal())
                self.caloriesSliderVal = self.breakfast.getCaloriesPerMeal()
                self.carbsSliderVal = self.breakfast.getCarbsPerMeal()
                self.proteinSliderVal = self.breakfast.getProteinPerMeal()
                self.fatSliderVal = self.breakfast.getFatsPerMeal()
                self.caloriesSlider.value = Float(self.caloriesSliderVal)
                self.carbsSlider.value = Float(self.carbsSliderVal)
                self.proteinSlider.value = Float(self.proteinSliderVal)
                self.fatSlider.value = Float(self.fatSliderVal)
            }
        })
    }
}

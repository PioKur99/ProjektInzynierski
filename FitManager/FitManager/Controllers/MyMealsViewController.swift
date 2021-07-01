//
//  MyMealsViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 28/06/2021.
//

import UIKit

class MyMealsViewController: UIViewController {
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
    var macronutrientsDictionary: [String:Int] = ["DK": 0, "DWW": 0, "DP": 0, "DF": 0,
                                                  "BK": 0, "BWW": 0, "BP": 0, "BF": 0,
                                                  "LK": 0, "LWW": 0, "LP": 0, "LF": 0,
                                                  "SK": 0, "SWW": 0, "SP": 0, "SF": 0,]
    
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
    }
    
}

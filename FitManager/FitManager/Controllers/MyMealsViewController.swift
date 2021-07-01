//
//  MyMealsViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 28/06/2021.
//

import UIKit

class MyMealsViewController: UIViewController {

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

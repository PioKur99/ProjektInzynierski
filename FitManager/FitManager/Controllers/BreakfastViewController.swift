//
//  BreakfastViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 01/07/2021.
//

import UIKit

class BreakfastViewController: UIViewController {
    @IBOutlet weak var breakfastTable: UITableView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addProductPress(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AddProdToMealViewController") as! AddProdToMealViewController
        resultViewController.whichMeal = "Breakfast"
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
}

//
//  MealViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 01/07/2021.
//

import UIKit
import Firebase

class MealViewController: UIViewController {
    @IBOutlet weak var breakfastTable: UITableView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var mealNameLabel: UILabel!
    var meal = Meal()
    var whichMeal = ""
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breakfastTable.dataSource = self
        breakfastTable.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mealNameLabel.text = whichMeal
        initTable()
    }
    
    @IBAction func addProductPress(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AddProdToMealViewController") as! AddProdToMealViewController
        resultViewController.whichMeal = whichMeal + "/"
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    @IBAction func addRecipeClick(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "RecipesViewController") as! RecipesViewController
        resultViewController.mode = whichMeal
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    func initTable() {
        meal.products.removeAll()
        DB.child(whichMeal).observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.meal.products.append(newProduct)
                self.breakfastTable.reloadData()
                self.caloriesLabel.text = String(self.meal.getCaloriesPerMeal())
                self.carbsLabel.text = String(self.meal.getCarbsPerMeal())
                self.proteinLabel.text = String(self.meal.getProteinPerMeal())
                self.fatLabel.text = String(self.meal.getFatsPerMeal())
            }
        })
    }
}

extension MealViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            breakfastTable.beginUpdates()
            let toDelete = self.meal.products[indexPath.row].location!
            DB.child(whichMeal + "/\(toDelete)").setValue(nil)
            self.meal.products.remove(at: indexPath.row)
            breakfastTable.deleteRows(at: [indexPath], with: .fade)
            self.caloriesLabel.text = String(self.meal.getCaloriesPerMeal())
            self.carbsLabel.text = String(self.meal.getCarbsPerMeal())
            self.proteinLabel.text = String(self.meal.getProteinPerMeal())
            self.fatLabel.text = String(self.meal.getFatsPerMeal())
            breakfastTable.endUpdates()
        }
    }
    
}

extension MealViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meal.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = breakfastTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.meal.products[indexPath.row].name + "     \(self.meal.products[indexPath.row].weight!)g"
        return cell
    }
}

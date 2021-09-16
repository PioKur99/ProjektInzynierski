//
//  RecipeCreationViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 13/09/2021.
//

import UIKit
import Firebase

class RecipeCreationViewController: UIViewController {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTable: UITableView!
    
    var recipeName: String = ""
    var meal = Meal()
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeNameLabel.text = recipeName
        recipeTable.delegate = self
        recipeTable.dataSource = self
        initTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initTable()
    }
    
    @IBAction func addProductPress(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AddProdToMealViewController") as! AddProdToMealViewController
        resultViewController.whichMeal = "Recipes/" + recipeName + "/"
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    func initTable() {
        meal.products.removeAll()
        DB.child("Recipes/" + recipeName).observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newProduct = Product(snapshot: child)
                self.meal.products.append(newProduct)
                self.recipeTable.reloadData()
                /*self.caloriesLabel.text = String(self.meal.getCaloriesPerMeal())
                self.carbsLabel.text = String(self.meal.getCarbsPerMeal())
                self.proteinLabel.text = String(self.meal.getProteinPerMeal())
                self.fatLabel.text = String(self.meal.getFatsPerMeal())*/
            }
        })
    }
}

extension RecipeCreationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recipeTable.beginUpdates()
            let toDelete = self.meal.products[indexPath.row].location!
            DB.child("Recipes/" + recipeName + "/\(toDelete)").setValue(nil)
            self.meal.products.remove(at: indexPath.row)
            recipeTable.deleteRows(at: [indexPath], with: .fade)
            /*self.caloriesLabel.text = String(self.meal.getCaloriesPerMeal())
            self.carbsLabel.text = String(self.meal.getCarbsPerMeal())
            self.proteinLabel.text = String(self.meal.getProteinPerMeal())
            self.fatLabel.text = String(self.meal.getFatsPerMeal())*/
            recipeTable.endUpdates()
        }
    }
    
}

extension RecipeCreationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meal.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.meal.products[indexPath.row].name + "     \(self.meal.products[indexPath.row].weight!)g"
        return cell
    }
}

//
//  RecipesViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 13/09/2021.
//

import UIKit
import Firebase

class RecipesViewController: UIViewController {
    
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    var mealsList: [Meal] = []
    @IBOutlet weak var mealsListTable: UITableView!
    @IBOutlet weak var mealsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealsListTable.delegate = self
        mealsListTable.dataSource = self
        mealsSearchBar.delegate = self
    }
    
    @IBAction func newMealButtonPress(_ sender: Any) {
    }
    
}

extension RecipesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension RecipesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        }
    }
}

extension RecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealsListTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        cell.name.text = self.mealsList[indexPath.row].name
        cell.calories.text = String(self.mealsList[indexPath.row].getCaloriesPerMeal())
        cell.carbs.text = String(self.mealsList[indexPath.row].getCarbsPerMeal())
        cell.protein.text = String(self.mealsList[indexPath.row].getProteinPerMeal())
        cell.fat.text = String(self.mealsList[indexPath.row].getFatsPerMeal())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


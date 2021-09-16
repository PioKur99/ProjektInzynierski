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
    var currMealsList: [Meal] = []
    @IBOutlet weak var mealsListTable: UITableView!
    @IBOutlet weak var mealsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealsListTable.delegate = self
        mealsListTable.dataSource = self
        mealsSearchBar.delegate = self
        getRecipesData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getRecipesData()
    }
    
    @IBAction func newMealButtonPress(_ sender: Any) {
        let alert = UIAlertController(title: "Wprowadź nazwę przepisu", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {field in})
        let closeAction = UIAlertAction(title: "Zamknij", style: .cancel)
        
        let okAction = UIAlertAction(title: "Zatwierdź", style: .default, handler: { _ in
            guard let fields = alert.textFields else {
                return
            }
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeCreationViewController") as! RecipeCreationViewController
            resultViewController.recipeName = fields[0].text!
            self.navigationController?.pushViewController(resultViewController, animated: true)
        })
        
        alert.addAction(closeAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    
    }
    
    func getRecipesData() {
        
        DB.child("Recipes").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let meal = Meal(mealName: child.key)
                for grandchild in child.children.allObjects as! [DataSnapshot] {
                    let product = Product(snapshot: grandchild)
                    meal.products.append(product)
                }
                self.mealsList.append(meal)
                self.currMealsList.append(meal)
                self.mealsListTable.reloadData()
            }
        })
    }
    
}


extension RecipesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            currMealsList = mealsList
            mealsListTable.reloadData()
            return
        }
        
        currMealsList = mealsList.filter({ meal -> Bool in
            guard let text = searchBar.text else {return false}
            return meal.name!.contains(text)
        })
        mealsListTable.reloadData()
    }
}

extension RecipesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeCreationViewController") as! RecipeCreationViewController
        resultViewController.recipeName = self.currMealsList[indexPath.row].name!
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            mealsListTable.beginUpdates()
            DB.child("Recipes/" + self.currMealsList[indexPath.row].name!).setValue(nil)
            self.currMealsList.remove(at: indexPath.row)
            mealsListTable.deleteRows(at: [indexPath], with: .fade)
            mealsList = currMealsList
            mealsListTable.endUpdates()
        }
    }
}

extension RecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currMealsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealsListTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        cell.name.text = self.currMealsList[indexPath.row].name
        cell.calories.text = String(self.currMealsList[indexPath.row].getCaloriesPerMeal())
        cell.carbs.text = String(self.currMealsList[indexPath.row].getCarbsPerMeal())
        cell.protein.text = String(self.currMealsList[indexPath.row].getProteinPerMeal())
        cell.fat.text = String(self.currMealsList[indexPath.row].getFatsPerMeal())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


//
//  BreakfastViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 01/07/2021.
//

import UIKit
import Firebase

class BreakfastViewController: UIViewController {
    @IBOutlet weak var breakfastTable: UITableView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    var meal = Meal()
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breakfastTable.dataSource = self
        breakfastTable.delegate = self
        initTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initTable()
    }
    
    @IBAction func addProductPress(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AddProdToMealViewController") as! AddProdToMealViewController
        resultViewController.whichMeal = "Breakfast/"
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    func initTable() {
        meal.products.removeAll()
        DB.child("Breakfast").observeSingleEvent(of: .value, with: {snapshot in
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

extension BreakfastViewController: UITableViewDelegate {
    
}

extension BreakfastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meal.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = breakfastTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.meal.products[indexPath.row].name + "     \(self.meal.products[indexPath.row].weight!)g"
        return cell
    }
}

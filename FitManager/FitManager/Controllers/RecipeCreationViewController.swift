//
//  RecipeCreationViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 13/09/2021.
//

import UIKit

class RecipeCreationViewController: UIViewController {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    var recipeName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeNameLabel.text = recipeName
    }
}

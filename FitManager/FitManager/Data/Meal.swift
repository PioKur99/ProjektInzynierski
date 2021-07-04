//
//  Meal.swift
//  FitManager
//
//  Created by Piotr Kurda on 04/07/2021.
//

import Foundation

class Meal {
    var products: [Product]
    
    init() {
        products = []
    }
    
    func getCaloriesPerMeal() -> Double {
        var kcalPerMeal: Double = 0.0
        
        for product in products {
            kcalPerMeal += (product.kcalPer100g * Double(product.weight!)) / 100
        }
        
        return kcalPerMeal
    }
    
    func getCarbsPerMeal() -> Double {
        var carbsPerMeal: Double = 0.0
        
        for product in products {
            carbsPerMeal += (product.carbsPer100g * Double(product.weight!)) / 100
        }
        
        return carbsPerMeal
    }
    
    func getProteinPerMeal() -> Double {
        var proteinsPerMeal: Double = 0.0
        
        for product in products {
            proteinsPerMeal += (product.proteinsPer100g * Double(product.weight!)) / 100
        }
        
        return proteinsPerMeal
    }
    
    func getFatsPerMeal() -> Double {
        var fatsPerMeal: Double = 0.0
        
        for product in products {
            fatsPerMeal += (product.fatsPer100g * Double(product.weight!)) / 100
        }
        
        return fatsPerMeal
    }
}

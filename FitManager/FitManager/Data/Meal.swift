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
        return Double(round(10*kcalPerMeal)/10)
    }
    
    func getCarbsPerMeal() -> Double {
        var carbsPerMeal: Double = 0.0
        
        for product in products {
            carbsPerMeal += (product.carbsPer100g * Double(product.weight!)) / 100
        }
        
        return Double(round(10*carbsPerMeal)/10)
    }
    
    func getProteinPerMeal() -> Double {
        var proteinsPerMeal: Double = 0.0
        
        for product in products {
            proteinsPerMeal += (product.proteinsPer100g * Double(product.weight!)) / 100
        }

        return Double(round(10*proteinsPerMeal)/10)
    }
    
    func getFatsPerMeal() -> Double {
        var fatsPerMeal: Double = 0.0
        
        for product in products {
            fatsPerMeal += (product.fatsPer100g * Double(product.weight!)) / 100
        }
        
        return Double(round(10*fatsPerMeal)/10)
    }
}


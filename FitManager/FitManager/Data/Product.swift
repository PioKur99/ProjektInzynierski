//
//  Product.swift
//  FitManager
//
//  Created by Piotr Kurda on 04/07/2021.
//

import Foundation

class Product {
    
    var name: String
    var manufacturer: String
    var kcalPer100g: Double
    var carbsPer100g: Double
    var proteinsPer100g: Double
    var fatsPer100g: Double
    var weight: Int? //Used when user provides how much of certain product he ate
    
    init(iName: String, iManu: String, iKcal: Double, iCarbs: Double, iProtein: Double, iFats: Double) {
        name = iName
        manufacturer = iManu
        kcalPer100g = iKcal
        carbsPer100g = iCarbs
        proteinsPer100g = iProtein
        fatsPer100g = iFats
    }
    
}

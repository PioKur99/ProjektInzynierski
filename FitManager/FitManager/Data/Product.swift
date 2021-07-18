//
//  Product.swift
//  FitManager
//
//  Created by Piotr Kurda on 04/07/2021.
//

import Foundation
import FirebaseDatabase

class Product {
    
    var name: String
    var manufacturer: String
    var kcalPer100g: Double
    var carbsPer100g: Double
    var proteinsPer100g: Double
    var fatsPer100g: Double
    var weight: Int? //Used when user provides how much of certain product he ate
    var location: String? //Number of node in DB
    
    init(iName: String, iManu: String, iKcal: Double, iCarbs: Double, iProtein: Double, iFats: Double) {
        name = iName
        manufacturer = iManu
        kcalPer100g = iKcal
        carbsPer100g = iCarbs
        proteinsPer100g = iProtein
        fatsPer100g = iFats
    }
    
    init() {
        name = ""
        manufacturer = ""
        kcalPer100g = 0.0
        carbsPer100g = 0.0
        proteinsPer100g = 0.0
        fatsPer100g = 0.0
    }
    
    init(snapshot: DataSnapshot) {
        let snap = snapshot.value as! NSDictionary
        name = snap["name"] as? String ?? ""
        manufacturer = snap["manufacturer"] as? String ?? ""
        kcalPer100g = snap["kcalPer100g"] as? Double ?? 0.0
        carbsPer100g = snap["carbsPer100g"] as? Double ?? 0.0
        proteinsPer100g = snap["proteinPer100g"] as? Double ?? 0.0
        fatsPer100g = snap["fatsPer100g"] as? Double ?? 0.0
        location = snapshot.key
    }
    
    func update(iName: String, iManu: String, iKcal: Double, iCarbs: Double, iProtein: Double, iFats: Double) {
        name = iName
        manufacturer = iManu
        kcalPer100g = iKcal
        carbsPer100g = iCarbs
        proteinsPer100g = iProtein
        fatsPer100g = iFats
    }
    
    func printProd() {
        print("Nazwa: \(name)")
        print("Producent: \(manufacturer)")
        print("Kalorie: \(kcalPer100g)")
        print("Wegle: \(carbsPer100g)")
        print("Bialko: \(proteinsPer100g)")
        print("Tluszcz: \(fatsPer100g)")
        print("Klucz: \(String(describing: location))")
        print("")
    }
}

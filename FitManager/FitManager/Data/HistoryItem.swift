//
//  HistoryItem.swift
//  FitManager
//
//  Created by Piotr Kurda on 12/08/2021.
//

import Foundation
import FirebaseDatabase

class HistoryItem {
    var date: String
    var caloriesAmount: Double
    
    init() {
        date = ""
        caloriesAmount = 0.0
    }
    
    init(snapshot: DataSnapshot) {
        let snap = snapshot.value as! NSDictionary
        date = snap["date"] as? String ?? ""
        caloriesAmount = snap["calories"] as? Double ?? 0.0
    }
    
    func printItem() {
        print("Data: \(date)")
        print("Kalorie: \(caloriesAmount)")
        print()
    }
    
}

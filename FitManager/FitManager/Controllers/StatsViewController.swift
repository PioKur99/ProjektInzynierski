//
//  StatsViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 06/08/2021.
//

import UIKit
import SwiftCharts
import FirebaseDatabase

class StatsViewController: UIViewController {
    
    var chartView: BarsChart!
    var caloriesLimit = 0.0
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let tempBMRNums = UserDefaults.standard.object(forKey: "BMRNumbs")
        if let BMRNums = tempBMRNums as? NSArray {
            let BMRValues = mapBMRValuesToStrings(inputArr: BMRNums)
            caloriesLimit = Double(BMRValues[7])!
        }
        initChartData()
    }
    
    func setUpChart(statsData: [HistoryItem]) {
        var barsArray: [(String, Double)] = []
        if (caloriesLimit < 500.0) {caloriesLimit = 2500.0}
        let chartConfig = BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: 0, to: caloriesLimit, by: 500))
        let sFrame = CGRect(x: 0, y: 50, width: self.view.frame.width - 20, height: self.view.frame.width + 225)
        for elem in statsData {
            print(elem.printItem())
            barsArray.append((elem.date,elem.caloriesAmount))
        }
        let chart = BarsChart(frame: sFrame, chartConfig: chartConfig, xTitle: "Dzień", yTitle: "Spożyte kalorie", bars: barsArray, color: UIColor.orange, barWidth: 30)
        self.view.addSubview(chart.view)
        self.chartView = chart
    }
    
    func initChartData() {
        var statsData: [HistoryItem] = []
        DB.child("History").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newEntry = HistoryItem(snapshot: child)
                statsData.append(newEntry)
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setUpChart(statsData: statsData)
        }
    }

}

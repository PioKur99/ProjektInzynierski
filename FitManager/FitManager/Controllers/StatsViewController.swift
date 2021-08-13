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
    var statsData: [HistoryItem] = []
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpChart()
        initChartData()
    }
    
    func updateChartData() {

    }
    
    func setUpChart() {
        let chartConfig = BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: 0, to: 4000, by: 500))
        let sFrame = CGRect(x: 0, y: 130, width: self.view.frame.width, height: self.view.frame.width)
        let barsArray = [(statsData[0].date,statsData[0].caloriesAmount),("Feb",110.8),("Mar",200),("Apr",310.6),("May",200),("Jun",410.5),("Jul",300)]
        let chart = BarsChart(frame: sFrame, chartConfig: chartConfig, xTitle: "Dzień", yTitle: "Spożyte kalorie", bars: barsArray, color: UIColor.orange, barWidth: 40)
        self.view.addSubview(chart.view)
        self.chartView = chart
    }
    
    func initChartData() {
        statsData.removeAll()
        DB.child("History").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newEntry = HistoryItem(snapshot: child)
                newEntry.printItem()
                self.statsData.append(newEntry)
                self.setUpChart()
            }
        })
    }

}

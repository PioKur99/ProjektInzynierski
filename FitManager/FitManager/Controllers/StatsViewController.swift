//
//  StatsViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 06/08/2021.
//

import UIKit
import Charts
import FirebaseDatabase

class StatsViewController: UIViewController, ChartViewDelegate {
    
    var statsChart = BarChartView()
    var statsData: [HistoryItem] = []
    let DB = Database.database(url: "https://fitmanager-database-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statsChart.delegate = self
        initChartData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statsChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        statsChart.center = view.center
        view.addSubview(statsChart)
        let set = BarChartDataSet(entries: [
            BarChartDataEntry(x: 10.0, y: 20.0),
            BarChartDataEntry(x: 15.0, y: 20.0),
            BarChartDataEntry(x: 20.0, y: 20.0),
        ])
        let data = BarChartData(dataSet: set)
        statsChart.data = data
    }
    
    func initChartData() {
        statsData.removeAll()
        DB.child("History").observeSingleEvent(of: .value, with: {snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let newEntry = HistoryItem(snapshot: child)
                newEntry.printItem()
                self.statsData.append(newEntry)
            }
        })
    }

}

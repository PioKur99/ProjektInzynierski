//
//  StatsViewController.swift
//  FitManager
//
//  Created by Piotr Kurda on 06/08/2021.
//

import UIKit
import Charts

class StatsViewController: UIViewController, ChartViewDelegate {
    
    var statsChart = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statsChart.delegate = self
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

}

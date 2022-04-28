//
//  ChartsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 4/27/22.
//

import UIKit
import FLCharts

class ChartsViewController: UIViewController {
    
    var symptomCheckin: SymptomCheckin?
    var barChart = FLChartBarCell()
    
    
    let monthsData = [MultiPlotable(name: "none", values: [0]),
                      MultiPlotable(name: "mild", values: [20, 60]),
                      MultiPlotable(name: "moderate", values: [100, 110]),
                      MultiPlotable(name: "difficult", values: [120]),
                      MultiPlotable(name: "severe", values: [150, 200, 250])]

    override func viewDidLoad() {

        super.viewDidLoad()
        
 
        let chartData = FLChartData(title: "Trigger1",
                                    data: monthsData,
                                    legendKeys: [
                        Key(key: "F1", color: .Gradient.lightBlue),
                        Key(key: "F2", color: .darkBlue),
                        Key(key: "F3", color: .Gradient.purpleLightBlue)],
                                     unitOfMeasure: "milligrams")
        let chart = FLChart(data: chartData, type: .bar())
    
        //        chart.config = FLChartConfig(granularityY: 20)


        let card = FLCard(chart: chart, style: .rounded)
        card.showAverage = true
        card.showLegend = false

        // Do any additional setup after loading the view.
        view.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            card.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          card.heightAnchor.constraint(equalToConstant: 300),
          card.widthAnchor.constraint(equalToConstant: 300)
        ])

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

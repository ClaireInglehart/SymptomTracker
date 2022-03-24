//
//  HistoryDateViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 3/10/22.
//

import UIKit
import FSCalendar

class HistoryDateViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    var calendar:FSCalendar!
    var formatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar = FSCalendar(frame:CGRect(x: 0.0, y: 100.0, width: self.view.frame.size.width, height: 300.0))
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17.0)
        
        self.view.addSubview(calendar)
        
        calendar.dataSource = self
        calendar.delegate = self
        
        // Do any additional setup after loading the view.
    }

    //MARK: - datasource
    
   
    
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy"
        print("Date Selected == \(formatter.string(from: date))")
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

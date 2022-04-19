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
        
        self.navigationItem.title = "Settings"
        
        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(onSignOut))
        self.navigationItem.leftBarButtonItem = signOutButton
    


        super.viewDidLoad()
        calendar = FSCalendar(frame:CGRect(x: 0.0, y: 100.0, width: self.view.frame.size.width, height: 300.0))
        calendar.scrollDirection = .vertical
        calendar.scope = .month
        
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 17.0)
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18.0)
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 16.0)
        
        calendar.appearance.todayColor = .systemGray
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.titleDefaultColor = .darkGray
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.selectionColor = .systemPurple
        
        
        
        self.view.addSubview(calendar)
        
        calendar.dataSource = self
        calendar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    @objc func onSignOut() {
        performSegue(withIdentifier: "SignOut", sender: nil)
    }


    //MARK: - datasource
    
   
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let currentUser = DataService.shared.currentUser else { return }

        let startDate = Foundation.Date()

        performSegue(withIdentifier: "showDateCheckin", sender: self)
        

        
    //for date selected, present the Checkin for that day, how severe symtpms were and what the trigger values were
//        performSegue(withIdentifier: "showCheckin", sender: FSCalendar.self)

    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {

            formatter.dateFormat = "dd-MMM-yyyy"
//            var dateSelected = formatter.string(from: date)
        }
    
    
//    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        formatter.dateFormat = "dd-MM-yyyy"
//
//    }
//


    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date().dateBySubtractingDays(365)
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
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


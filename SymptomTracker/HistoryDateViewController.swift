//
//  HistoryDateViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 3/10/22.
//

import UIKit
import FSCalendar
import Foundation


class HistoryDateViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var calendar:FSCalendar!
    var formatter = DateFormatter()
    private var checkins: [Checkin] = []
    private var selectedCheckin: Checkin?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.navigationItem.title = "Check-in History"
        
        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(onSignOut))
        self.navigationItem.leftBarButtonItem = signOutButton
                 
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
        calendar.appearance.selectionColor = .systemBlue
                        
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
        
        if let dateCheckin = (DataService.shared.getCheckin(forDate: date, forUser: currentUser)) {
            self.selectedCheckin = dateCheckin
            performSegue(withIdentifier: "ShowCheckin", sender: self)
        } else {
            self.showErrorToast(withMessage: "There is no check-in for that date")
        }
    }
    
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        guard let currentUser = DataService.shared.currentUser else { return false }
        
        return (DataService.shared.getCheckin(forDate: date, forUser: currentUser) != nil)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        guard let currentUser = DataService.shared.currentUser else { return 0 }
        
        if let _ = (DataService.shared.getCheckin(forDate: date, forUser: currentUser)) {
            return 1
        }
        return 0
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date().dateBySubtractingDays(365)
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "ShowCheckin", let vc = segue.destination as? CheckinHistoryViewController {
             vc.checkin = self.selectedCheckin
         }
     }
}


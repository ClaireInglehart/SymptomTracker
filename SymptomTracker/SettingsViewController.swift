//
//  SettingsViewController.swift
//  SymptomTracker
//
//  Created by Mike on 2/22/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var notification1Switch: UISwitch!
    @IBOutlet weak var notification2Switch: UISwitch!
    
    @IBOutlet weak var notifPicker2: UIDatePicker!
    @IBOutlet weak var notifPicker1: UIDatePicker!
    
    let notification1Identifier = "notification1"
    let notification2Identifier = "notification2"
    
    var hourMinuteTimeFormatter: DateFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Settings"

        self.notification1Switch.onTintColor = .systemIndigo
        self.notification2Switch.onTintColor = .systemIndigo
        
        self.notification1Switch.isOn = AppSettings.notification1Enabled
        self.notification2Switch.isOn = AppSettings.notification2Enabled
        
        self.notifPicker1.isEnabled = AppSettings.notification1Enabled
        self.notifPicker2.isEnabled = AppSettings.notification2Enabled
        
        let notification1TimeString = AppSettings.notification1Time ?? "17:00"
        let notification2TimeString = AppSettings.notification2Time ?? "17:00"
        
        // Notification times are stored as strings. Convert to date.
        self.hourMinuteTimeFormatter = DateFormatter()
        self.hourMinuteTimeFormatter.dateFormat = "HH:mm"
        
        let notification1Time = self.hourMinuteTimeFormatter.date(from: notification1TimeString) ?? Date()
        let notification2Time = self.hourMinuteTimeFormatter.date(from: notification2TimeString) ?? Date()
        
        let date1 = Date().dateWithHour(hour: notification1Time.getHour(), minute: notification1Time.getMinute(), second: 0)
        let date2 = Date().dateWithHour(hour: notification2Time.getHour(), minute: notification2Time.getMinute(), second: 0)
        
        self.notifPicker1.date = date1 ?? Date()
        self.notifPicker2.date = date2 ?? Date()
        
        self.scheduleTestNotification()
    }
    
    @IBAction func onNotification1SwitchValueChanged(_ sender: UISwitch) {
        AppSettings.notification1Enabled = sender.isOn
        self.notifPicker1.isEnabled = AppSettings.notification1Enabled
        
        self.cancelNotification(withIdentifier: notification1Identifier)
        if (sender.isOn) {
            self.scheduleNotification1 {
                
            }
        }
    }
    
    @IBAction func onNotification2SwitchValueChanged(_ sender: UISwitch) {
        AppSettings.notification2Enabled = sender.isOn
        self.notifPicker2.isEnabled = AppSettings.notification2Enabled
        
        self.cancelNotification(withIdentifier: notification2Identifier)
        if (sender.isOn) {
            self.scheduleNotification2 {
                
            }
        }
    }
    
    @IBAction func onTimePicker1ValueChanged(_ sender: UIDatePicker) {
        self.cancelNotification(withIdentifier: notification1Identifier)

        // Convert date to string for saving
        let notification1TimeString = self.hourMinuteTimeFormatter.string(from: sender.date)
        AppSettings.notification1Time = notification1TimeString
        
        self.scheduleNotification1 {
        }
    }
    
    @IBAction func onTimePicker2ValueChanged(_ sender: UIDatePicker) {
        self.cancelNotification(withIdentifier: notification2Identifier)

        // Convert date to string for saving
        let notification2TimeString = self.hourMinuteTimeFormatter.string(from: sender.date)
        AppSettings.notification2Time = notification2TimeString
        
        self.scheduleNotification2 {
        }
    }
    
    func cancelNotification(withIdentifier identifier: String) {
        print("cancelNotification id:\(identifier)")
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func scheduleNotification1(onCompletion completion: @escaping ()->()) {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if (granted) {
                // create notification trigger
                let notification1TimeString = AppSettings.notification1Time ?? "17:00"
                let notification1Time = self.hourMinuteTimeFormatter.date(from: notification1TimeString) ?? Date()
                let notificationDate = Date().dateWithHour(hour: notification1Time.getHour(), minute: notification1Time.getMinute(), second: 0)!
                self.scheduleNotification(withIdentifier: self.notification1Identifier, withDate: notificationDate)
                
            } else {
                print("NOT granted")
                AppSettings.notification1Enabled = false
                self.notification1Switch.isOn = false
                self.notifPicker1.isEnabled = false
            }
            completion()
        }
        
    }
    
    func scheduleNotification2(onCompletion completion: @escaping ()->()) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if (granted) {
                // create notification trigger
                let notification2TimeString = AppSettings.notification2Time ?? "17:00"
                let notification2Time = self.hourMinuteTimeFormatter.date(from: notification2TimeString) ?? Date()
                let notificationDate = Date().dateWithHour(hour: notification2Time.getHour(), minute: notification2Time.getMinute(), second: 0)!
                self.scheduleNotification(withIdentifier: self.notification2Identifier, withDate: notificationDate)
            } else {
                print("NOT granted")
                AppSettings.notification2Enabled = false
                self.notification2Switch.isOn = false
                self.notifPicker2.isEnabled = false
            }
            completion()
        }
    }
    
    func scheduleNotification(withIdentifier identifier: String, withDate notificationDate: Date) {
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = "Time for your daily check-in!"
        content.body = "Please tap this notification and then enter your trigger values for today."
        
        var triggerDateComponents = DateComponents()
        triggerDateComponents.calendar = Calendar.current
        triggerDateComponents.weekday = notificationDate.getWeekday()
        triggerDateComponents.hour = notificationDate.getHour()
        triggerDateComponents.minute = notificationDate.getMinute()
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            print("scheduleNotification id:\(identifier) time:(\(triggerDateComponents.hour):\(triggerDateComponents.minute) error:\(error)")
        }
    }
    
    func scheduleTestNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if (granted) {
                let content = UNMutableNotificationContent()
                content.title = "Weekly Staff Meeting"
                content.body = "Every Tuesday at 2pm"
                
                let triggerDate = Date().dateByAddingMinutes(2)
                
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                dateComponents.weekday = triggerDate.getWeekday()
                dateComponents.hour = triggerDate.getHour()
                dateComponents.minute = triggerDate.getMinute()
                
                // Create the trigger as a repeating event.
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
                
                // Schedule the request with the system.
                let notificationCenter = UNUserNotificationCenter.current()
                notificationCenter.add(request) { (error) in
                    if error != nil {
                        // Handle any errors.
                    }
                    print("scheduleTestNotification (\(dateComponents.hour):\(dateComponents.minute): \(error)")
                }
                
            } else {
                print("NOT granted")
            }
        }
        
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


extension Date {
    func dateWithHour (hour: Int, minute:Int, second:Int) -> Date? {
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([.day, .month, .year], from: self)
        components.hour = hour;
        components.minute = minute;
        components.second = second;
        return calendar.date(from: components)
    }
    
    func getHour() -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.hour], from: self)
        return components.hour ?? 17
    }
    
    func getMinute() -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.minute], from: self)
        return components.minute ?? 0
    }

    func getWeekday() -> Int {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday ?? 0
    }
    
    func dateByAddingMinutes(_ dMinutes: NSInteger) -> Date {
        let aTimeInterval = self.timeIntervalSinceReferenceDate + Double(60.0) * Double(dMinutes)
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval)
        return newDate
    }

}

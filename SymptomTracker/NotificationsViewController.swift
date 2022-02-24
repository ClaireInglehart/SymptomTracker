//
//  NotificationsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit
import UserNotifications

class NotificationsViewController: UIViewController {


    @IBOutlet weak var notifPicker2: UIDatePicker!
    @IBOutlet weak var notifPicker1: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
        }
        
        //create notificatoin content
        let content = UNMutableNotificationContent()
        
        content.title = "Im a notification!"
        content.body = "Im the body of the notification!"
        
        //create notification trigger - the date on the picker(aka time)
//        let date = notifPicker1.date

        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        dateFormatter.string(from: date)
        
        
        print("Date notif1Picker: ", date.formatted())
        //creates components of that date - the day, the hour, the minute
        
        //dateComponents of UI Picker
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: date)
                
        print("date components: ", dateComponents)
        //sets the trigger to that dateCompnent
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //create request from notifications and trigger
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            //check the error parameter and handle any errors

        }
        
    }

    
    @IBAction func onDone(_ sender: Any) {
        
        //capture date shown on picker 1
        let notifPicker1 = notifPicker1.date.formatted(date: .long, time: .standard)
        
//        let notifPicker2 = notifPicker2.date
//        notifPicker1
        print("🔔notif1 Time: ", notifPicker1)
//        print("🔔🔔notif2 Time: ", notifPicker2)

        
        // TODO: verify user has set up notifications?
        
        performSegue(withIdentifier: "SetupComplete", sender: sender)

    }

}

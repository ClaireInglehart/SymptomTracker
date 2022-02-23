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
        
        //create notification trigger
        let date = Date().addingTimeInterval(5)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //create request from notifiactions and trigger
        //make unique identifer
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            //check the error parameter and handle any errors

        }
        
    }

    
    @IBAction func onDone(_ sender: Any) {
        
        //capture date shown on picker 1
        let notifPicker1 = notifPicker1.date
        let notifPicker2 = notifPicker2.date
        notifPicker1
        print("🔔notif1 Time: ", notifPicker1)
        print("🔔🔔notif2 Time: ", notifPicker2)

        
        // TODO: verify user has set up notifications?
        
        performSegue(withIdentifier: "SetupComplete", sender: sender)

    }

}

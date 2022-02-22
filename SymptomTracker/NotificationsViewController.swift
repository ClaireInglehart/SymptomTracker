//
//  NotificationsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit
import UserNotifications

class NotificationsViewController: UIViewController {
    func requestAuthorization(completion: @escaping  (Bool) -> Void) {
      UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
          // TODO: Fetch notification settings
          completion(granted)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            if granted {
                print("permission yes")
            } else {
                print("permisson no")
            }
        }
    }
    

    
    @IBAction func onDone(_ sender: Any) {
        // TODO: verify user has set up notifications?
        
        performSegue(withIdentifier: "SetupComplete", sender: sender)

    }

}

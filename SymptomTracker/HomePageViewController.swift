//
//  HomePageViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class HomePageViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This notification gets posted from StartupViewController when the
        // user taps on the notification banner
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(doCheckinNotification(_:)),
                                               name: NSNotification.Name ("daily.checkin"),
                                               object: nil)
    }
        
    @objc func doCheckinNotification(_ notification: Notification) {
        self.selectedIndex = 2      // Select Check-in tab
    }
    
    
}

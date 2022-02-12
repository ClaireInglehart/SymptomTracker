//
//  HomePageViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class HomePageViewController: UITabBarController {

    public var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        print("🧑🏼‍🦰 HomePageViewController: user=\(self.user.email)")
        
        // Pass user to each child view controller
        if let navControllers = self.viewControllers {
            for navController in navControllers {
                if let nav = navController as? UINavigationController {
                    if let vc = nav.viewControllers[0] as? SymptomsViewController {
                        vc.user = self.user
                    } else if let vc = nav.viewControllers[0] as? TriggersViewController {
                        vc.user = self.user
                    } else if let vc = nav.viewControllers[0] as? HistoryViewController {
                        vc.user = self.user
                    } else if let vc = nav.viewControllers[0] as? CheckInViewController {
                        vc.user = self.user
                    }
                }
            }
        }
    }
    
}

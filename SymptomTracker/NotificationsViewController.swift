//
//  NotificationsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class NotificationsViewController: UIViewController {

    public var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
   
        print("🧑🏼‍🦰 NotificationsViewController: user=\(self.user.email)")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoHome"), let vc = segue.destination as? HomePageViewController {
            vc.user = user!
        }
    }

    @IBAction func onDone(_ sender: Any) {
        // TODO: verify user has set up notifications?
        
        performSegue(withIdentifier: "GoHome", sender: sender)

    }

}

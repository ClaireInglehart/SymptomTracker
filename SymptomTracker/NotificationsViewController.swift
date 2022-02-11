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
    }

    @IBAction func onDone(_ sender: Any) {
        // TODO: verify user has set up notifications?
        
        performSegue(withIdentifier: "GoHome", sender: sender)

    }

}

//
//  SignUpTriggersViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class SignUpTriggersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Trigger(s)"
    }

    @IBAction func onContinue(_ sender: Any) {
        // TODO: verify user added at least one trigger
        
        performSegue(withIdentifier: "Notifications", sender: sender)

    }

}

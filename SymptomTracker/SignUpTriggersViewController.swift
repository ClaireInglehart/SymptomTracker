//
//  SignUpTriggersViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class SignUpTriggersViewController: UIViewController {
    public var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Your Triggers"
        
        print("🧑🏼‍🦰 SignUpTriggersViewController: user=\(self.user.email)")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Notifications"), let vc = segue.destination as? NotificationsViewController {
            vc.user = user!
        }
    }


    @IBAction func onContinue(_ sender: Any) {
        // TODO: verify user added at least one trigger
        
        performSegue(withIdentifier: "Notifications", sender: sender)
        
    }

}

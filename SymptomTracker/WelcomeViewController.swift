//
//  WelcomeViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.continueButton.layer.cornerRadius = 8.0

        if let currentUser = DataService.shared.currentUser {
            self.welcomeLabel.text = "Welcome, \(currentUser.email)!"
        }
    }
    
    @IBAction func onContinue(_ sender: Any) {
        
        performSegue(withIdentifier: "SignUpAddSymptoms", sender: sender)
        
    }


}

//
//  WelcomeViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = DataService.shared.currentUser {
            self.welcomeLabel.text = "Welcome, \(currentUser.name)!"
        }
    }
    
    @IBAction func onContinue(_ sender: Any) {
        
        performSegue(withIdentifier: "SignUpAddSymptoms", sender: sender)
        
    }


}

//
//  WelcomeViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!

    public var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeLabel.text = "Welcome, \(self.user.name)!"

        print("🧑🏼‍🦰 WelcomeViewController: user=\(self.user.email)")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SignUpSymptoms"), let vc = segue.destination as? SignUpSymptomsViewController {
            vc.user = user!
        }
    }

}

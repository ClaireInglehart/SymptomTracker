//
//  CheckInViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class CheckInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Check-ins"

        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(onSignOut))
        self.navigationItem.leftBarButtonItem = signOutButton
    }
    
    @objc func onSignOut() {
        performSegue(withIdentifier: "SignOut", sender: nil)
    }


    @IBAction func onDoCheckin(_ sender: Any) {
        // TODO: verify user added at least one symptom
        
        performSegue(withIdentifier: "DoCheckIn", sender: sender)

    }


}

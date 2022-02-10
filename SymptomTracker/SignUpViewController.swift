//
//  SignUpViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //continue button to welcome view

    @IBAction func onContinue(_ sender: Any) {
        // TODO: verify name and email were entered
        
        performSegue(withIdentifier: "ShowWelcome", sender: sender)

    }
}

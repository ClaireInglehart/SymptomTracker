//
//  ViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class LoginViewController:
    UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.layer.cornerRadius = 10

    }

    
    //login button segue to home page
    @IBAction func login(_ sender: Any) {
        performSegue(withIdentifier: "GoHome", sender: sender)
    }
    
}

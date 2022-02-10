//
//  ViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class LoginViewController:
    UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.layer.cornerRadius = 10

    }

    //Name Field
    
    //login button segue to home page
    @IBAction func login(_ sender: Any) {
        performSegue(withIdentifier: "GoHome", sender: sender)
    }
    
}

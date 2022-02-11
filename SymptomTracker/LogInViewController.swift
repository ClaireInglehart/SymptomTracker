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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoHome"), let vc = segue.destination as? HomePageViewController {
            
        }
    }
    
    //login button segue to home page
    @IBAction func login(_ sender: Any) {
//        if let email = emailField.text, email.count > 0, let user = DataService.shared.getUser(forEmail: email) {
            performSegue(withIdentifier: "GoHome", sender: sender)
//        } else {
//            let title = "Account Not Found"
//            var message = "An account for this user was not found. Please sign up."
//            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Sign Up", style: .cancel, handler: { _ in
//                self.performSegue(withIdentifier: "SignUp", sender: sender)
//            }))
//            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { _ in
//            }))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
}

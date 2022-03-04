//
//  ViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.layer.cornerRadius = 10
        emailField.delegate = self
        
        passwordField.layer.cornerRadius = 10
        passwordField.delegate = self

        self.continueButton.layer.cornerRadius = 8.0
        self.signUpButton.layer.cornerRadius = 8.0

        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(onTrash))
        self.navigationItem.rightBarButtonItem = trashButton
    }

    @objc func onTrash() {
        DataService.shared.trash()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailField.text = nil
        passwordField.text = nil

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailField.becomeFirstResponder()
    }

    //login button segue to home page
    @IBAction func onContinue(_ sender: Any) {
        guard let email = emailField.text, email.count > 0 else { return }
        guard let password = passwordField.text, password.count > 0 else { return }

        if let user = DataService.shared.getUser(forEmail: email, forPassword: password) {
            DataService.shared.currentUser = user
            // if the user has completed set up, go home.
            // Otherwise, continue set up
            if (user.symptoms.count > 0) {
                performSegue(withIdentifier: "GoHome", sender: sender)
            } else {
                performSegue(withIdentifier: "SignUpSymptoms", sender: sender)
            }
        } else {
            let title = "Account Not Found"
            let message = "An account for this user was not found. Please sign up."
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sign Up", style: .default, handler: { _ in
                self.performSegue(withIdentifier: "SignUp", sender: sender)
            }))
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func onSignUp(_ sender: Any) {
        self.performSegue(withIdentifier: "SignUp", sender: sender)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.emailField) {
            if let email = textField.text, email.count > 0 {
                self.passwordField.becomeFirstResponder()
                return true
            }
        } else if (textField == self.passwordField) {
            if let email = textField.text, email.count > 0,
               let password = passwordField.text, password.count > 0{
                self.onContinue(textField)
                return true
            }
        }
        return false
    }
}


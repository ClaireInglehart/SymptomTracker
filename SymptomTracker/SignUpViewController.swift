//
//  SignUpViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//
import LocalAuthentication
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        
        self.continueButton.layer.cornerRadius = 8.0
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailField.becomeFirstResponder()
    }
    
    
    @IBAction func onContinue(_ sender: Any) {
        guard let email = emailField.text, email.count > 0 else { return }

        
        guard let password = passwordField.text, password.count > 0 else { return }

        let passwordDigest = password.sha256()
      
        if DataService.shared.userExists(withEmail: email) {
            let title = "Account Already Exists"
            let message = "An account with this email address already exists. Please sign in."
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)

        } else {
        
            if let newUser = DataService.shared.addUser(withEmail: email, withPasswordDigest: passwordDigest) {
                DataService.shared.currentUser = newUser
                performSegue(withIdentifier: "ShowWelcome", sender: sender)
            } else {
                let title = "Account Error"
                let message = "An error occurred. Please try again."
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.emailField) {
//            if let email = textField.text, email.count > 0 {
                self.passwordField.becomeFirstResponder()
                return true
            
        } else if (textField == self.passwordField) {
//            if let email = textField.text, email.count > 0,
//               let password = textField.text, password.count > 0 {
//                }
                self.onContinue(textField)
                passwordField.resignFirstResponder()

                return true
            }
        return false
        }
}

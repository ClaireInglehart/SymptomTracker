//
//  SignUpViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//
import LocalAuthentication
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.delegate = self
        emailField.delegate = self
    
    
    
    }
    @IBAction func touchID(_ sender: UIButton) {
            let context = LAContext()
            var error: NSError? = nil
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                    let reason = "Please evaluate with touch id"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                    DispatchQueue.main.async {
                        
                        guard success, error == nil else {
                            //failed
                            
                                //cannot evaluate faceid
                                let alert = UIAlertController(title: "Failed to Authenticate",
                                message: "Please try again",
                                                              preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Dismiss",
                                                              style: .cancel, handler: nil))
                            self?.present(alert, animated: true)
                            return
                        }
        
                        self?.performSegue(withIdentifier: "ShowWelcome", sender: sender)
                    }
                }
            }
        
        else {
            //cannot evaluate faceid
            let alert = UIAlertController(title: "Unavailable",
            message: "You cant use this feature",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",
                                          style: .cancel, handler: nil))
            present(alert, animated: true)
            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.nameField.becomeFirstResponder()
    }
    
    @IBAction func onContinue(_ sender: Any) {
        guard let name = nameField.text, name.count > 0,
              let email = emailField.text, email.count > 0 else { return }

        // Make sure an account with this email doesn't already exist
        if let _ = DataService.shared.getUser(forEmail: email) {
            let title = "Account Already Exists"
            let message = "An account with this email address already exists. Please sign in."
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)

        } else {
        
            if let newUser = DataService.shared.addUser(withName: name, email: email) {
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
        if (textField == self.nameField) {
            if let name = textField.text, name.count > 0 {
                self.emailField.becomeFirstResponder()
                return true
            }
        } else if (textField == self.emailField) {
            if let email = textField.text, email.count > 0 {
                self.onContinue(textField)
                return true
            }
        }
        return false
    }

}

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
    private var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.nameField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowWelcome"),
            let nav = segue.destination as? UINavigationController,
            let welcomeVC = nav.viewControllers[0] as? WelcomeViewController {
            welcomeVC.user = user!
        }
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
                self.user = newUser
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
}

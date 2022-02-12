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
    private var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.layer.cornerRadius = 10

        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(onTrash))
        self.navigationItem.rightBarButtonItem = trashButton
    }

    @objc func onTrash() {
        DataService.shared.trash()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailField.becomeFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoHome"), let vc = segue.destination as? HomePageViewController {
            vc.user = user!
        } else if (segue.identifier == "SignUpSymptoms"), let vc = segue.destination as? SignUpSymptomsViewController {
            vc.user = user!
        }

    }
    
    //login button segue to home page
    @IBAction func onContinue(_ sender: Any) {
        guard let email = emailField.text, email.count > 0 else { return }
                
        if let user = DataService.shared.getUser(forEmail: email) {
            self.user = user
            // if the user has completed set up, go home.
            // Otherwise, continue set up
            if ((user.symptoms.count > 0) && (user.triggers.count > 0)) {
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
}

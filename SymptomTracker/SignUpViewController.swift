//
//  SignUpViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Name Field TextField
    @IBOutlet weak var NameField: UITextField!
    
    //continue button to welcome view
    @IBAction func Continue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeVC = storyboard.instantiateViewController(identifier: "WelcomeView")
        
        welcomeVC.modalPresentationStyle = .fullScreen
        welcomeVC.modalTransitionStyle = .crossDissolve
        
        present(welcomeVC, animated: true, completion: nil)
    }
}

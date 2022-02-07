//
//  ViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class LoginViewController:
    UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //Name Field
    @IBOutlet weak var NameField: UITextField!
    
    
    //login button segue to home page
    @IBAction func login(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homePageVC = storyboard.instantiateViewController(identifier: "HomePageView")
        
        homePageVC.modalPresentationStyle = .fullScreen
        homePageVC.modalTransitionStyle = .crossDissolve
    
        present(homePageVC, animated: true, completion: nil)
    }
    //signup button segue to sign up page
    @IBAction func SignUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(identifier: "WelcomeView")
        
        signUpVC.modalPresentationStyle = .fullScreen
        signUpVC.modalTransitionStyle = .crossDissolve
        
        present(signUpVC, animated: true, completion: nil)

    }
}

//
//  WelcomeViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //continue button to sign up symptoms view
    @IBAction func Continue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SignUpVC = storyboard.instantiateViewController(identifier: "SignUpSymptomsView")
        
        SignUpVC.modalPresentationStyle = .fullScreen
        SignUpVC.modalTransitionStyle = .crossDissolve
        
        present(SignUpVC, animated: true, completion: nil)

    }

}

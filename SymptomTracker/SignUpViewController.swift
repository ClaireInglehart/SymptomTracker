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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

    }
    
    //Name Field TextField
    @IBOutlet weak var NameField: UITextField!

    //continue button to welcome view

    @IBAction func Continue(_ sender: Any) {
        performSegue(withIdentifier: "GoWelcome", sender: sender)

    }
}

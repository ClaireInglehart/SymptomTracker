//
//  AddCheckinValueViewController.swift
//  SymptomTrackeroh!Q
//
//  Created by Claire Inglehart on 3/22/22.
//

import UIKit

class AddCheckinValueViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    

    var customTrigger: CustomTrigger?
    @IBOutlet weak var userValue: UITextField!
    public var newValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userValue.delegate = self
    
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancel))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    

    @objc func onCancel() {
        self.dismiss(animated: true, completion: nil)
    }
        // Do any additional setup after loading the view.
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userValue.becomeFirstResponder()

    }
    
    func textFieldShouldReturn(_ nameInput: UITextField) -> Bool {
        nameInput.resignFirstResponder()
        return true
    }

    
    @IBAction func onDone(_ sender: UIButton) {
        if let userValue = userValue.text, userValue.isEmpty == false {
            
            self.newValue = userValue
            
        } else {
        self.showErrorToast(withMessage: "Please enter a value!")
        }
    }
}

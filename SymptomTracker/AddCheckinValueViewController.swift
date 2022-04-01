//
//  AddCheckinValueViewController.swift
//  SymptomTrackeroh!Q
//
//  Created by Claire Inglehart on 3/22/22.
//

import UIKit

class AddCheckinValueViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    

    var customTrigger: CustomTrigger?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    public var newValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        valueTextField.delegate = self
    
        if let trigger = self.customTrigger {
            self.titleLabel.text = "Please add value for \(trigger.name)"
            self.valueTextField.placeholder = "Enter value in \(trigger.units)"
        }
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancel))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    

    @objc func onCancel() {
        self.dismiss(animated: true, completion: nil)
    }
        // Do any additional setup after loading the view.
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        valueTextField.becomeFirstResponder()

    }
    
    func textFieldShouldReturn(_ nameInput: UITextField) -> Bool {
        nameInput.resignFirstResponder()
        return true
    }

    
    @IBAction func onDone(_ sender: UIButton) {
        if let userValue = valueTextField.text, userValue.isEmpty == false{
                   self.newValue = userValue
                   performSegue(withIdentifier: "valueAdded", sender: self)
               } else {
                   self.showErrorToast(withMessage: "Please enter a value!")
        }
    }
}

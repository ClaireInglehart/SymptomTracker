//
//  AddTriggerViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/12/22.
//

import UIKit

class AddTriggerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var unitInput: UITextField!   
    @IBOutlet weak var nameField: UITextField!
    
    public var symptom: Symptom?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameInput.delegate = self
        unitInput.delegate = self

        self.title = "Add Trigger"

        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancel))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    

    @objc func onCancel() {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameInput.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == nameInput {
            nameInput.resignFirstResponder()
            unitInput.becomeFirstResponder()
        }else if textField == unitInput {
                    unitInput.resignFirstResponder()
        }
        return true
    }

    @IBAction func onDone(_ sender: UIButton) {

        guard let symptom = self.symptom else { return }

        if let item = nameInput.text, item.isEmpty == false,
           let units = unitInput.text, units.isEmpty == false {
            
            let newTrigger = Trigger(name: item, units: units)
            DataService.shared.addTrigger(newTrigger, forSymptom: symptom)
            
            performSegue(withIdentifier: "TriggerAdded", sender: sender)
        }
        
        
    }
    
    
    
    
    
    
    
}

//
//  AddTriggerViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/12/22.
//

import UIKit

class AddTriggerViewController: UIViewController {

    private var trigger : Trigger?
    private var user: User?
    @IBOutlet weak var nameField: UITextField!

    
    @IBAction func onEnter(_ sender: Any) {
        //check to make sure nameField isn't empty
        guard let name = nameField.text, name.count > 0 else
        { return }
        
            
        }
    
    
            
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func enterTrigger(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


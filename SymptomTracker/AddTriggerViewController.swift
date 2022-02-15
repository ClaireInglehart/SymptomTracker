//
//  AddTriggerViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/12/22.
//

import UIKit

class AddTriggerViewController: UIViewController {
    
    @IBOutlet weak var unitInput: UITextField!
    
    @IBOutlet weak var nameInput: UITextField!
    
    public var user: User!

    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        print("🧑🏼‍🦰 AddTriggerViewController: user=\(self.user.email)")
}

    
    @IBAction func onEnter(_ sender: UIButton) {
        
        if let item = nameInput.text, item.isEmpty == false,
                let units = unitInput.text,
                   units.isEmpty == false {
                    let newTrigger = Trigger(name: item, units: units)
                    DataService.shared.addTrigger(newTrigger, forUser: self.user)
        

        }

        performSegue(withIdentifier: "TriggerAdded", sender: sender)

 }

    
    
}



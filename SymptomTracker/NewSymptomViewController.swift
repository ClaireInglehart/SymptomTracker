//
//  NewSymptomViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/11/22.
//

import UIKit

class NewSymptomViewController: UIViewController {

    public var user: User!

    @IBOutlet weak var nameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        print("🧑🏼‍🦰 NewSymptomViewController: user=\(self.user.email)")
    }
    

    //Enter button to store arrayList of Symptoms by user
    @IBAction func enter(_ sender: UIButton) {
        
        if let item = nameInput.text, item.isEmpty == false {
            let newSymptom = Symptom(name: item)
            DataService.shared.addSymptom(newSymptom, forUser: self.user)
        }

        performSegue(withIdentifier: "SymptomAdded", sender: sender)
    }


}

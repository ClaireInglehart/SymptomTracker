//
//  NewSymptomViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/11/22.
//

import UIKit

class NewSymptomViewController: UIViewController {

    @IBOutlet weak var nameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameInput.becomeFirstResponder()
    }
    

    //Enter button to store arrayList of Symptoms by user
    @IBAction func enter(_ sender: UIButton) {
        
        guard let currentUser = DataService.shared.currentUser else { return }

        if let item = nameInput.text, item.isEmpty == false {
            let newSymptom = Symptom(name: item)
            DataService.shared.addSymptom(newSymptom, forUser: currentUser)
        }

        performSegue(withIdentifier: "SymptomAdded", sender: sender)
    }


}

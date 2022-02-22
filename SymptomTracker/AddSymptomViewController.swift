//
//  AddSymptomViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/11/22.
//

import UIKit

class AddSymptomViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameInput: UITextField!
    var newSymptom: Symptom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameInput.delegate = self
        
        self.title = "Add Symptom"

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
    
    func textFieldShouldReturn(_ nameInput: UITextField) -> Bool {
        nameInput.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUpAddTriggers",
           let vc = segue.destination as? SignUpTriggersViewController {
               vc.symptom = self.newSymptom
        }
    }

        
    @IBAction func onDone(_ sender: UIButton) {
        
        guard let currentUser = DataService.shared.currentUser else { return }

        if let symptomName = nameInput.text, symptomName.isEmpty == false {
            let newSymptom = Symptom(name: symptomName)
            DataService.shared.addSymptom(newSymptom, forUser: currentUser)
            self.newSymptom = newSymptom
            performSegue(withIdentifier: "SignUpAddTriggers", sender: sender)
        }

    }


}

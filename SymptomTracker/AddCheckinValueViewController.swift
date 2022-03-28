//
//  AddCheckinValueViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 3/22/22.
//

import UIKit

class AddCheckinValueViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    var customTrigger: CustomTrigger?
    @IBOutlet weak var userValue: UITextField!
    var dialogMessage = UIAlertController(title: "Attention", message: "I am an alert message you cannot dissmiss.", preferredStyle: .alert)

    @IBAction func onDone(_ sender: UIButton) {
        if let userValue = userValue.text, userValue.isEmpty == false{
            performSegue(withIdentifier: "valueAdded", sender: self)
            
        }
        self.present(dialogMessage, animated: true, completion: nil)

    }
    
    

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

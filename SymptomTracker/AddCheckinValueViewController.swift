//
//  AddCheckinValueViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 3/22/22.
//

import UIKit

class AddCheckinValueViewController: UIViewController {

    var customTrigger: CustomTrigger?
    
    
    
    
    
    @IBOutlet weak var userValue: UITextField!
    
    @IBAction func onDone(_ sender: Any) {
        if (User.customValue.count > 0) {
            performSegue(withIdentifier: "valueAdded", sender: sender)
        } else {
            let message = "Error: Please add a value"
            self.showWarningToast(withMessage: message)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

//
//  AddCheckinValueViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 3/22/22.
//

import UIKit

class AddCheckinValueViewController: UIViewController {

    @IBAction func valueAdded(_ segue: UIStoryboardSegue) {
        performSegue(withIdentifier: "newCheckinValue", sender: self)    }
    
        @IBAction func doneButton(_ sender: UIStoryboardSegue) {
            performSegue(withIdentifier: "valueAdded", sender: self)

    }
    
    @IBOutlet weak var userValue: UITextField!
    
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

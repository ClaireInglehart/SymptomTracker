//
//  AddCheckinValueViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 3/22/22.
//

import UIKit

class AddCheckinValueViewController: UIViewController {

    
    
    
    @IBAction func onDone(_ sender: Any) {
        performSegue(withIdentifier: "unwindToThisViewController", sender: self)
    }
    
    @IBAction func valueAdded(_ segue: UIStoryboardSegue) {
        performSegue(withIdentifier: "addValue", sender: self)    }
    
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

//
//  CheckInViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class CheckInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onDoCheckin(_ sender: Any) {
        // TODO: verify user added at least one symptom
        
        performSegue(withIdentifier: "DoCheckIn", sender: sender)

    }


}

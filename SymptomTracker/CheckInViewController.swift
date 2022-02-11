//
//  CheckInViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class CheckInViewController: UIViewController {

    public var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Check-ins"
    }
    

    @IBAction func onDoCheckin(_ sender: Any) {
        // TODO: verify user added at least one symptom
        
        performSegue(withIdentifier: "DoCheckIn", sender: sender)

    }


}

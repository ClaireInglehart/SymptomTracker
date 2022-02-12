//
//  SignUpSymptomsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit
import SwiftUI

class SignUpSymptomsViewController: UIViewController {

    public var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Symptom(s)"
        
        print("🧑🏼‍🦰 SignUpSymptomsViewController: user=\(self.user.email)")        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowSignUpAddTriggers"), let vc = segue.destination as? SignUpTriggersViewController {
            vc.user = user!
        }
    }

    @IBAction func onContinue(_ sender: Any) {
        // TODO: verify user added at least one symptom
        
        performSegue(withIdentifier: "ShowSignUpAddTriggers", sender: sender)

    }

}

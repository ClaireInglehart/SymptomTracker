//
//  SignUpSymptomsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit
import SwiftUI

class SignUpSymptomsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onContinue(_ sender: Any) {
        // TODO: verify user added at least one symptom
        
        performSegue(withIdentifier: "ShowSignUpAddTriggers", sender: sender)

    }

}

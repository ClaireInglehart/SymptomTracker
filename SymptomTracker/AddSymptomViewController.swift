//
//  AddSymptom.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/10/22.
//

import UIKit

class AddSymptom: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBOutlet weak var symptomName: UITextField!
    
    //Create empty list of symptom names
    
    var symptomNames: [String] = []
    
    
    @IBAction func Enter(_ sender: Any) {
        if let symptomItem = symptomName.text, symptomItem.isEmpty == false {
            symptomNames.append(symptomItem)
        }
        
        
        symptomName.text = nil //Clean text Field
        for symp in symptomNames {
            print(symp) // prints the items currently in the list
        }
    }
}
    

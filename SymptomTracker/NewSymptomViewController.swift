//
//  NewSymptomViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/11/22.
//

import UIKit

class NewSymptomViewController: UIViewController {

        
    @IBOutlet weak var nameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    //Enter button to store arrayList of Symptoms by user
    @IBAction func enter(_ sender: UIButton) {
        var symptomList: [String] = []
        
        if let item = nameInput.text, item.isEmpty == false {
            symptomList.append(item)
        }
        nameInput.text = nil
    
        for input in symptomList {
            print(input)
        }
        self.dismiss(animated: true, completion: nil)
    }


}

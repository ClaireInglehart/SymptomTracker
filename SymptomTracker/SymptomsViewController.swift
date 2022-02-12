//
//  SymptomsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class SymptomsViewController: UIViewController {

    public var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Symptoms"

        print("🧑🏼‍🦰 SymptomsViewController: user=\(self.user.email)")
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

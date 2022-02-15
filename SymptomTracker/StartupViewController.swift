//
//  StartupViewController.swift
//  SymptomTracker
//
//  Created by Mike on 2/15/22.
//

import UIKit

class StartupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (DataService.shared.currentUser == nil) {
            self.performSegue(withIdentifier: "ShowLogin", sender: self)
        }
    }
    
    @IBAction func setupComplete(_ segue: UIStoryboardSegue) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.performSegue(withIdentifier: "GoHome", sender: nil)
        }
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

//
//  StartupViewController.swift
//  SymptomTracker
//
//  Created by Mike on 2/15/22.
//

import UIKit

class StartupViewController: UIViewController {

    public var user: User!
    private var firstTime = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (firstTime) {
            self.performSegue(withIdentifier: "ShowLogin", sender: self)
            firstTime = false
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoHome"), let vc = segue.destination as? HomePageViewController {
            vc.user = user!
        }
    }

    @IBAction func setupComplete(_ segue: UIStoryboardSegue) {
        if let vc = segue.source as? NotificationsViewController {
            self.user = vc.user
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.performSegue(withIdentifier: "GoHome", sender: nil)
            }
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

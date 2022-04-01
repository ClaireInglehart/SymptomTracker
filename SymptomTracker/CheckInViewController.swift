//
//  CheckInViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class CheckInViewController: UIViewController {

    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var checkInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Check-ins"

        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(onSignOut))
        self.navigationItem.leftBarButtonItem = signOutButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let currentUser = DataService.shared.currentUser else { return }
        
        if (DataService.shared.getCheckin(forDate: Date(), forUser: currentUser) != nil) {
            self.checkInButton.isHidden = true
            self.checkInLabel.isHidden = false
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.checkInLabel.text = "Check-in complete for today, \(dateFormatter.string(from: Date()))"
        } else {
            self.checkInButton.isHidden = false
            self.checkInLabel.isHidden = true
        }
    }
    
    @objc func onSignOut() {
        performSegue(withIdentifier: "SignOut", sender: nil)
    }


    @IBAction func onDoCheckin(_ sender: Any) {
        // TODO: verify user added at least one symptom
        
        performSegue(withIdentifier: "DoDailyCheckIn", sender: sender)

    }

    @IBAction func dailyCheckinComplete(_ segue: UIStoryboardSegue) {
        print("dailyCheckinComplete")
    }
    
    @IBAction func dailyCheckinCanceled(_ segue: UIStoryboardSegue) {
        print("dailyCheckinCanceled")
   }

}

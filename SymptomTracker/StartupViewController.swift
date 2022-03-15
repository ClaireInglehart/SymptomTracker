//
//  StartupViewController.swift
//  SymptomTracker
//
//  Created by Mike on 2/15/22.
//

import UIKit
import Lottie

class StartupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let startupAnimationView = AnimationView(name: "chatbot")
        startupAnimationView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(startupAnimationView)
        let constraints = [
            startupAnimationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            startupAnimationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)

        startupAnimationView.play { (finished) in
          /// Animation finished
            if (DataService.shared.currentUser == nil) {
                self.performSegue(withIdentifier: "ShowLogin", sender: self)
            }
        }

    }
    
    @IBAction func setupComplete(_ segue: UIStoryboardSegue) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.performSegue(withIdentifier: "GoHome", sender: nil)
        }
    }

    // "unwind" segue - handles sign out from any other screen
    @IBAction func onSignOut( _ seg: UIStoryboardSegue) {
        DataService.shared.currentUser = nil
    }
    

    public func doCheckin() {
        // Show the "home" view controller
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.performSegue(withIdentifier: "GoHome", sender: nil)
            
            // Post a notification. This will be handled by HomePageViewController.
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                NotificationCenter.default.post(name: NSNotification.Name("daily.checkin"), object: nil)
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

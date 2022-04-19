//
//  WelcomeViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit
import Lottie

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!

    @IBOutlet weak var lottieView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.continueButton.layer.cornerRadius = 8.0

        if let currentUser = DataService.shared.currentUser {
            self.welcomeLabel.text = "Welcome!"
        }
        
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .loop
        
        lottieView.animationSpeed = 0.5
        lottieView.play()
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        let startupAnimationView = AnimationView(name: "welcome-bot")
//        startupAnimationView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(startupAnimationView)
//        let constraints = [
//            startupAnimationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            startupAnimationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//        ]
//        NSLayoutConstraint.activate(constraints)
//
//        startupAnimationView.play { (finished) in
//          /// Animation finished
//            if (DataService.shared.currentUser == nil) {
//                self.performSegue(withIdentifier: "ShowLogin", sender: self)
//            }
//        }
//    }

    @IBAction func onContinue(_ sender: Any) {
        performSegue(withIdentifier: "SignUpAddSymptoms", sender: sender)
        
    }


}

//
//  SignUpTriggersViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class SignUpTriggersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    public var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Your Triggers"
        
        print("🧑🏼‍🦰 SignUpTriggersViewController: user=\(self.user.email)")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Notifications"), let vc = segue.destination as? NotificationsViewController {
            vc.user = user!
        } else if (segue.identifier == "addTrigger"), let vc = segue.destination as? AddTriggerViewController {
            vc.user = user!
        }
    }
    


    @IBAction func onContinue(_ sender: Any) {
        // TODO: verify user added at least one trigger
        
        performSegue(withIdentifier: "TriggersToNotifications", sender: sender)
        
    }

    @IBAction func triggerAdded(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.user.triggers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let trigger = self.user.triggers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
        cell.textLabel?.text = trigger.name
        return cell
    }
}


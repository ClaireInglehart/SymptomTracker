//
//  TriggersViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class TriggersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var user: User!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Triggers"

        print("🧑🏼‍🦰 TriggersViewController: user=\(self.user.email)")
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
        cell.textLabel?.text = "\(trigger.name) (\(trigger.units))"
        return cell
    }

        
    

    

}

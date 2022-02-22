//
//  SignUpTriggersViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class SignUpTriggersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    public var symptom: Symptom?
    @IBOutlet weak var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Your Triggers"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let symptom = self.symptom {
            self.doneButton.isHidden = (symptom.triggers.count == 0)
        }
    }

    @IBAction func onDone(_ sender: Any) {
        guard let symptom = self.symptom else { return }

        if (symptom.triggers.count > 0) {
            performSegue(withIdentifier: "SymptomAdded", sender: sender)
        } else {
            let title = "Set Up"
            let message = "Please add at least one Trigger"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddTrigger",
           let nav = segue.destination as? UINavigationController,
            let vc = nav.viewControllers[0] as? AddTriggerViewController {
               vc.symptom = self.symptom
        }
    }

    
    @IBAction func triggerAdded(_ segue: UIStoryboardSegue) {
        if let symptom = self.symptom {
            self.doneButton.isHidden = (symptom.triggers.count == 0)
        }
        tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let symptom = self.symptom else { return 0 }

        return symptom.triggers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let symptom = self.symptom else { return UITableViewCell() }

        let trigger = symptom.triggers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
        cell.textLabel?.text = trigger.name
        cell.detailTextLabel?.text = trigger.units
        return cell
    }

    
}

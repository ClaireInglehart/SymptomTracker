//
//  SignUpTriggersViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit
import DZNEmptyDataSet
import HealthKit

class SignUpTriggersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    if HKHealthStore.isHealthDataAvailable() {
        //add some code about healthkit here
    }
    
    let healthStore = HKHealthStore()
    
    public var symptom: Symptom?
    private var triggers: [Trigger] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self

        self.title = "Your Triggers"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.doneButton.isHidden = (triggers.count == 0)
    }

    @IBAction func onDone(_ sender: Any) {
        guard let symptom = self.symptom else { return }
        guard let currentUser = DataService.shared.currentUser else { return }

        if (triggers.count > 0) {
            DataService.shared.addSymptom(symptom, forUser: currentUser)
            for trigger in triggers {
                DataService.shared.addTrigger(trigger, forSymptom: symptom)
            }
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
//        if segue.identifier == "AddTrigger",
//           let nav = segue.destination as? UINavigationController,
//            let vc = nav.viewControllers[0] as? AddTriggerViewController {
//               vc.triggers = self.triggers
//        }
    }

    
    @IBAction func triggerAdded(_ segue: UIStoryboardSegue) {
        if let vc = segue.source as? AddTriggerViewController,
            let newTrigger = vc.newTrigger {
           
            self.triggers.append(newTrigger)
            self.doneButton.isHidden = (triggers.count == 0)
            tableView.reloadData()
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return triggers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let trigger = triggers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
        cell.textLabel?.text = trigger.name
        cell.detailTextLabel?.text = trigger.units
        return cell
    }

    
}


extension SignUpTriggersViewController : DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Please add at least 1 trigger")
    }
}

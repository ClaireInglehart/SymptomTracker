//
//  SignUpTriggersViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit
import DZNEmptyDataSet

class SignUpTriggersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!    
    @IBOutlet weak var addCustomTriggerButton: UIButton!
    @IBOutlet weak var addAppleHealthTriggerButton: UIButton!

    public var symptom: Symptom?
    private var customTriggers: [CustomTrigger] = []
    private var appleHealthTriggers: [AppleHealthTrigger] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        self.title = "Your Triggers"
        
        self.doneButton.layer.cornerRadius = 8.0
        self.addCustomTriggerButton.layer.cornerRadius = 8.0
        self.addAppleHealthTriggerButton.layer.cornerRadius = 8.0

        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancel))
        self.navigationItem.leftBarButtonItem = cancelButton

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.doneButton.isHidden = (customTriggers.count == 0) && (appleHealthTriggers.count == 0)
    }

    @objc func onCancel() {
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func onDone(_ sender: Any) {
        guard let symptom = self.symptom else { return }
        guard let currentUser = DataService.shared.currentUser else { return }
        
        if ((customTriggers.count > 0) || (appleHealthTriggers.count > 0)) {
            DataService.shared.addSymptom(symptom, forUser: currentUser)
            for trigger in customTriggers {
                DataService.shared.addCustomTrigger(trigger, forSymptom: symptom)
            }
            for appleHealthTrigger in appleHealthTriggers {
                DataService.shared.addAppleHealthTrigger(appleHealthTrigger, forSymptom: symptom)
            }
            performSegue(withIdentifier: "SymptomAdded", sender: sender)
        } else {
            let message = "Please add at least one Trigger"
            self.showWarningToast(withMessage: message)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    
    @IBAction func addTriggerCanceled(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func triggerAdded(_ segue: UIStoryboardSegue) {
        if let vc = segue.source as? AddTriggerViewController,
           let newTrigger = vc.newTrigger {
            
            self.customTriggers.append(newTrigger)
            self.doneButton.isHidden = (customTriggers.count == 0) && (appleHealthTriggers.count == 0)
            tableView.reloadData()
        }
    }
    
    @IBAction func appleHealthTriggersAdded(_ segue: UIStoryboardSegue) {
        if let vc = segue.source as? AddAppleHealthTriggerViewController {
            let newTriggers = vc.newTriggers
            self.appleHealthTriggers.append(contentsOf: newTriggers)
            self.doneButton.isHidden = (customTriggers.count == 0) && (appleHealthTriggers.count == 0)
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return customTriggers.count
        } else {
            return appleHealthTriggers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            let trigger = customTriggers[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
            cell.textLabel?.text = trigger.name
            cell.detailTextLabel?.text = trigger.units
            return cell
        } else {
            let trigger = appleHealthTriggers[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
            cell.textLabel?.text = trigger.name
            cell.detailTextLabel?.text = nil
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            if (self.customTriggers.count > 0) {
                return "Custom Triggers"
            }
        } else {
            if (self.appleHealthTriggers.count > 0) {
                return "Apple Health Triggers"
            }
        }
        return nil
    }
    
    
}


extension SignUpTriggersViewController : DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Please add at least 1 trigger")
    }
}

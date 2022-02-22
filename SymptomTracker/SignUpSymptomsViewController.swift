//
//  SignUpSymptomsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit
import DZNEmptyDataSet

class SignUpSymptomsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        self.title = "Your Symptoms"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let currentUser = DataService.shared.currentUser {
            self.continueButton.isHidden = currentUser.symptoms.count == 0
        }
    }

    @IBAction func onAddSymptom(_ sender: Any) {
        performSegue(withIdentifier: "NewSymptom", sender: sender)
        
    }

    @IBAction func onContinue(_ sender: Any) {
        
        guard let currentUser = DataService.shared.currentUser else { return }

        if (currentUser.symptoms.count > 0) {
            performSegue(withIdentifier: "Notifications", sender: sender)
        } else {
            let title = "Set Up"
            let message = "Please add at least one Symptom"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction func symptomAdded(_ segue: UIStoryboardSegue) {
        if let currentUser = DataService.shared.currentUser {
            self.continueButton.isHidden = currentUser.symptoms.count == 0
        }
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let currentUser = DataService.shared.currentUser else { return 0 }

        return currentUser.symptoms.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let currentUser = DataService.shared.currentUser else { return 0 }

        return currentUser.symptoms[section].triggers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let currentUser = DataService.shared.currentUser else { return UITableViewCell() }

        let symptom = currentUser.symptoms[indexPath.section]
        let trigger = symptom.triggers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
        cell.textLabel?.text = trigger.name
        cell.detailTextLabel?.text = trigger.units
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let currentUser = DataService.shared.currentUser else { return "n/a" }
        
        let symptom = currentUser.symptoms[section]
        return "Symptom: \(symptom.name)"
    }

}

extension SignUpSymptomsViewController : DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Please add at least 1 symptom")
    }
}

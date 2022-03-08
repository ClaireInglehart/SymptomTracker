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
    @IBOutlet weak var addSymptomButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        self.addSymptomButton.layer.cornerRadius = 8.0
        self.continueButton.layer.cornerRadius = 8.0

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
            let message = "Please add at least one Symptom"
            self.showWarningToast(withMessage: message)
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

        return currentUser.symptoms[section].customTriggers.count +
               currentUser.symptoms[section].appleHealthTriggers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let currentUser = DataService.shared.currentUser else { return UITableViewCell() }

        let symptom = currentUser.symptoms[indexPath.section]
        if (indexPath.row < symptom.customTriggers.count) {
            let trigger = symptom.customTriggers[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
            cell.textLabel?.text = trigger.name
            cell.detailTextLabel?.text = trigger.units
            return cell
        } else {
            let trigger = symptom.appleHealthTriggers[indexPath.row - symptom.customTriggers.count]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
            cell.textLabel?.text = trigger.name
            cell.detailTextLabel?.text = nil
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let currentUser = DataService.shared.currentUser else { return UIView() }
        let symptom = currentUser.symptoms[section]

        let view = UIView()
        view.backgroundColor = UIColor.systemIndigo
        
        let symptomLabel = UILabel()
        symptomLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(symptomLabel)
        symptomLabel.text = "Symptom: \(symptom.name)"
        symptomLabel.textColor = .white

        let symptomLabelConstraints = [
            symptomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            symptomLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0),
            symptomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16.0),
        ]
        NSLayoutConstraint.activate(symptomLabelConstraints)

        let triggersLabel = UILabel()
        triggersLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(triggersLabel)
        triggersLabel.text = "Triggers:"
        triggersLabel.textColor = .white

        let triggersLabelConstraints = [
            triggersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            triggersLabel.topAnchor.constraint(equalTo: symptomLabel.bottomAnchor, constant: 4.0),
            triggersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16.0),
            triggersLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0)
        ]
        NSLayoutConstraint.activate(triggersLabelConstraints)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }


}

extension SignUpSymptomsViewController : DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Please add at least 1 symptom")
    }
}

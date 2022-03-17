//
//  DailyCheckinViewController.swift
//  SymptomTracker
//

import UIKit

class DailyCheckinViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var checkin: Checkin?
    var symptomCheckins: [SymptomCheckin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        self.navigationItem.title = "Check-in for \(dateFormatter.string(from: Date()))"
    
        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(onSignOut))
        self.navigationItem.leftBarButtonItem = signOutButton

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    

    @objc func onSignOut() {
        performSegue(withIdentifier: "SignOut", sender: nil)
    }

    @objc func onDone() {
        // Display an "are you sure?" alert if some triggers don't have values.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            let hasCheckin = false
            let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
            cell.textLabel?.text = trigger.name
            if (hasCheckin) {
                cell.detailTextLabel?.text = "the value goes here"
                cell.detailTextLabel?.textColor = .label
                cell.accessoryType = .none
            } else {
                cell.detailTextLabel?.text = "Check In"
                cell.detailTextLabel?.textColor = .systemIndigo
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        } else {
            let trigger = symptom.appleHealthTriggers[indexPath.row - symptom.customTriggers.count]
            let hasCheckin = false
            let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
            cell.textLabel?.text = trigger.name
            if (hasCheckin) {
                cell.detailTextLabel?.text = "the value goes here"
                cell.detailTextLabel?.textColor = .label
                cell.accessoryType = .none
            } else {
                cell.detailTextLabel?.text = "Check In"
                cell.detailTextLabel?.textColor = .systemIndigo
                cell.accessoryType = .disclosureIndicator
            }
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
        guard let currentUser = DataService.shared.currentUser else { return false }
        let symptom = currentUser.symptoms[indexPath.section]
        if (indexPath.row < symptom.customTriggers.count) {
            let hasCheckin = false
            return !hasCheckin

        } else {
            let hasCheckin = false
            return !hasCheckin
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let currentUser = DataService.shared.currentUser else { return indexPath }
        let symptom = currentUser.symptoms[indexPath.section]
        if (indexPath.row < symptom.customTriggers.count) {
            let hasCheckin = false
            return hasCheckin ? nil : indexPath

        } else {
            let hasCheckin = false
            return hasCheckin ? nil : indexPath
        }
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // If it's a custom trigger, show a screen to prompt user to enter value
        // if it's an Apple Health trigger, query AH for the value
    }
}

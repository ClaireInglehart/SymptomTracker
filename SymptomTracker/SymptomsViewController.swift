//
//  SymptomsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit
import Lottie


class SymptomsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Symptoms"
    
        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(onSignOut))
        self.navigationItem.leftBarButtonItem = signOutButton

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddSymptom))

//        let testButton = UIBarButtonItem(title: "test", style: .plain, target: self, action: #selector(onMakeTestData))
//        self.navigationItem.rightBarButtonItems = [addButton, testButton]
    }
    

    @objc func onSignOut() {
        performSegue(withIdentifier: "SignOut", sender: nil)
    }

    @objc func onAddSymptom() {
        performSegue(withIdentifier: "AddSymptom", sender: nil)
    }

    @IBAction func symptomAdded(_ segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
//    @objc func onMakeTestData() {
//        guard let currentUser = DataService.shared.currentUser else { return }
//
//        DataService.shared.mlTest(forUser: currentUser)
//    }


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
        view.backgroundColor = UIColor.systemBlue
        
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

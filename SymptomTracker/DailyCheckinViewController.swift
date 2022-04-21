//
//  DailyCheckinViewController.swift
//  SymptomTracker
//

import UIKit
import HealthKit
import SVProgressHUD

class DailyCheckinViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var checkin: Checkin!
    var selectedSymptom: Symptom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        self.navigationItem.title = "Check-in for \(dateFormatter.string(from: Date()))"
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancel))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.checkin = Checkin(date: Date(), symptomCheckins: [])
    }
    
    @objc func onCancel() {
        // TODO: display an "are you sure?" alert if some changes have been made
        
        self.performSegue(withIdentifier: "DailyCheckinCanceled", sender: self)
    }
    
    @objc func onDone() {
        // TODO: display an "are you sure?" alert if some triggers don't have values.
        
        guard let currentUser = DataService.shared.currentUser else { return }
        
        DataService.shared.addCheckin(self.checkin, forUser: currentUser)
        self.performSegue(withIdentifier: "DailyCheckinComplete", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkinSymptom",
           let nav = segue.destination as? UINavigationController,
           let vc = nav.viewControllers[0] as? SymptomCheckinViewController {
            
            vc.symptom = self.selectedSymptom
        }
    }
    
    @IBAction func symtomCheckinComplete(_ segue: UIStoryboardSegue) {
        print("symtomCheckinComplete")
        if let vc = segue.source as? SymptomCheckinViewController, let checkin = vc.symptomCheckin {            
            self.checkin.symptomCheckins.append(checkin)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func symtomCheckinCanceled(_ segue: UIStoryboardSegue) {
        print("symtomCheckinCanceled")
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let currentUser = DataService.shared.currentUser else { return 0 }
        return currentUser.symptoms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let currentUser = DataService.shared.currentUser else { return UITableViewCell() }
        
        let symptom = currentUser.symptoms[indexPath.row]
        let hasCheckin = self.checkin.symptomCheckins.contains { checkin in
            return symptom.name == checkin.symptom.name
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomCell", for: indexPath)
        cell.textLabel?.text = symptom.name
        if (hasCheckin) {
            cell.detailTextLabel?.text = nil
            cell.accessoryType = .checkmark
        } else {
            cell.detailTextLabel?.text = "Check In"
            cell.detailTextLabel?.textColor = .systemBlue
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        
        let symptomLabel = UILabel()
        symptomLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(symptomLabel)
        symptomLabel.text = "Symptoms"
        symptomLabel.textColor = .white
        
        let symptomLabelConstraints = [
            symptomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            symptomLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0),
            symptomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16.0),
            symptomLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0)
        ]
        NSLayoutConstraint.activate(symptomLabelConstraints)
        return view
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        guard let currentUser = DataService.shared.currentUser else { return false }
        let symptom = currentUser.symptoms[indexPath.row]
        if let _ = self.checkin.checkinForSymptom(symptom) {
            return false    // already checked in
        }
        return true
    }
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let currentUser = DataService.shared.currentUser else { return nil }
        let symptom = currentUser.symptoms[indexPath.row]
        if let symptomCheckin = self.checkin.checkinForSymptom(symptom) {
            return nil    // already checked in
        }
        return indexPath
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let currentUser = DataService.shared.currentUser else { return }
        
        self.selectedSymptom = currentUser.symptoms[indexPath.row]
        self.performSegue(withIdentifier: "checkinSymptom", sender: tableView)
    }
    
    
}

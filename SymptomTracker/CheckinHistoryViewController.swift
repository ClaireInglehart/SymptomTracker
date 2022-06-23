//
//  CheckinHistoryViewController.swift
//  SymptomTracker
//

import UIKit

class CheckinHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var checkin: Checkin!
    private var selectedSymptomCheckin: SymptomCheckin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "History"
        
        if let checkin = self.checkin {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.dateLabel.text = "Check-in for \(dateFormatter.string(from: checkin.date))"
            self.navigationItem.title = dateFormatter.string(from: checkin.date)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSymptomCheckin", let vc = segue.destination as? SymptomCheckinHistoryViewController {
            vc.symptomCheckin = self.selectedSymptomCheckin
        }
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        guard let checkin = self.checkin else { return 0 }
        return checkin.symptomCheckins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let checkin = self.checkin else { return UITableViewCell() }

        let symptomCheckin = checkin.symptomCheckins[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomCell", for: indexPath)
        cell.textLabel?.text = symptomCheckin.symptom.name
        cell.accessoryType = .disclosureIndicator
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
        return true
    }
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let checkin = self.checkin else { return }
        self.selectedSymptomCheckin = checkin.symptomCheckins[indexPath.row]
        
        self.performSegue(withIdentifier: "ShowSymptomCheckin", sender: tableView)
    }
    
    
}

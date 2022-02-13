//
//  SignUpSymptomsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class SignUpSymptomsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    public var user: User!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Symptoms"
        
        print("🧑🏼‍🦰 SignUpSymptomsViewController: user=\(self.user.email)")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowSignUpAddTriggers"), let vc = segue.destination as? SignUpTriggersViewController {
            vc.user = user! }
        else if (segue.identifier == "NewSymptom"), let vc = segue.destination as?
                    NewSymptomViewController {
            vc.user = self.user
        }
    }
    
    
    @IBAction func onContinue(_ sender: Any) {
        // TODO: verify user added at least one symptom
        
        performSegue(withIdentifier: "ShowSignUpAddTriggers", sender: sender)
        
    }
    
    @IBAction func symptomAdded(_ segue: UIStoryboardSegue) {
        
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.user.symptoms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let symptom = self.user.symptoms[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomCell", for: indexPath)
        cell.textLabel?.text = symptom.name
        return cell
    }
}

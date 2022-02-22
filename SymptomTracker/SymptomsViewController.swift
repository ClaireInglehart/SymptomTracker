//
//  SymptomsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class SymptomsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Symptoms"
    
        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(onSignOut))
        self.navigationItem.leftBarButtonItem = signOutButton
    }
    

    @objc func onSignOut() {
        performSegue(withIdentifier: "SignOut", sender: nil)
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

        return currentUser.symptoms[section].triggers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let currentUser = DataService.shared.currentUser else { return UITableViewCell() }

        let symptom = currentUser.symptoms[indexPath.section]
        let trigger = symptom.triggers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomCell", for: indexPath)
        cell.textLabel?.text = trigger.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let currentUser = DataService.shared.currentUser else { return "n/a" }
        
        let symptom = currentUser.symptoms[section]
        return "Symptom: \(symptom.name)"
    }
    
    

}

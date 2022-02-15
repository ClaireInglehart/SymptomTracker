//
//  SymptomsViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class SymptomsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    public var user: User!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Symptoms"

        print("🧑🏼‍🦰 SymptomsViewController: user=\(self.user.email)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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

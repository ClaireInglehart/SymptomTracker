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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.checkin = Checkin(date: Date(), symptomCheckins: [])
    }
    
    @objc func onSignOut() {
        performSegue(withIdentifier: "SignOut", sender: nil)
    }
    
    @objc func onDone() {
        // TODO: display an "are you sure?" alert if some triggers don't have values.
        
        
        guard let currentUser = DataService.shared.currentUser else { return }

        DataService.shared.addCheckin(self.checkin, forUser: currentUser)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
            cell.textLabel?.text = trigger.name
            var triggerCheckin: AppleHealthTriggerCheckin?
            if let symptomCheckin = self.checkin.checkinForSymptom(symptom) {
                triggerCheckin = symptomCheckin.appleHealthTriggerCheckins.first(where: { t in
                    return t.trigger.identifier == trigger.identifier
                })
            }

            if triggerCheckin != nil {
                cell.detailTextLabel?.text = "\(triggerCheckin!.quantity)"
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
        if let symptomCheckin = self.checkin.checkinForSymptom(symptom) {
            if (indexPath.row < symptom.customTriggers.count) {
                let customTrigger = symptom.customTriggers[indexPath.row]
                let hasCheckin = symptomCheckin.customTriggerCheckins.contains { customTriggerCheckin in
                    return customTrigger.name == customTriggerCheckin.trigger.name
                }
                return hasCheckin ? false : true
                
            } else {
                let appleHealthTrigger = symptom.appleHealthTriggers[indexPath.row - symptom.customTriggers.count]
                let hasCheckin = symptomCheckin.appleHealthTriggerCheckins.contains { appleHealthTriggerCheckin in
                    return appleHealthTrigger.identifier == appleHealthTriggerCheckin.trigger.identifier
                }
                return hasCheckin ? false : true
            }
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let currentUser = DataService.shared.currentUser else { return nil }
        let symptom = currentUser.symptoms[indexPath.section]
        if let symptomCheckin = self.checkin.checkinForSymptom(symptom) {
            if (indexPath.row < symptom.customTriggers.count) {
                let customTrigger = symptom.customTriggers[indexPath.row]
                let hasCheckin = symptomCheckin.customTriggerCheckins.contains { customTriggerCheckin in
                    return customTrigger.name == customTriggerCheckin.trigger.name
                }
                return hasCheckin ? nil : indexPath
                
            } else {
                let appleHealthTrigger = symptom.appleHealthTriggers[indexPath.row - symptom.customTriggers.count]
                let hasCheckin = symptomCheckin.appleHealthTriggerCheckins.contains { appleHealthTriggerCheckin in
                    return appleHealthTrigger.identifier == appleHealthTriggerCheckin.trigger.identifier
                }
                return hasCheckin ? nil : indexPath
            }
        } else {
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let currentUser = DataService.shared.currentUser else { return }

        let symptom = currentUser.symptoms[indexPath.section]
        // If it's a custom trigger, show a screen to prompt user to enter value
        // If it's a custom trigger, show a screen to prompt user to enter value
        
        if (indexPath.row < symptom.customTriggers.count) {
            let customTrigger = symptom.customTriggers[indexPath.row]
            
        } else {
            let appleHealthTrigger = symptom.appleHealthTriggers[indexPath.row - symptom.customTriggers.count]
            
            self.queryHealthKit(forIdentifier: appleHealthTrigger.identifier) { quantity in
                let appleHealthTriggerCheckin = AppleHealthTriggerCheckin(trigger: appleHealthTrigger, quantity: quantity)
                if let symptomCheckin = self.checkin.checkinForSymptom(symptom) {
                    symptomCheckin.appleHealthTriggerCheckins.append(appleHealthTriggerCheckin)
                } else {
                    // TODO: need UI to set symptom severity
                    let symptomCheckin = SymptomCheckin(symptom: symptom, severity: .moderate)
                    symptomCheckin.symptom = symptom
                    symptomCheckin.appleHealthTriggerCheckins = [appleHealthTriggerCheckin]
                    symptomCheckin.customTriggerCheckins = []
                    self.checkin.symptomCheckins.append(symptomCheckin)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
    func queryHealthKit(forIdentifier identifier: HKQuantityTypeIdentifier, completion: @escaping (Double) -> Void) {
        
        var healthStore : HKHealthStore!
        
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
        else {
            self.showHealthKitNotSupportedAlert {
                completion(0.0)
                return
            }
        }
        let quantityType = HKQuantityType.quantityType(forIdentifier: identifier)!
        let readRequestTypes:Set<HKQuantityType> = [quantityType]
        
        SVProgressHUD.show()
        healthStore.requestAuthorization(toShare: nil, read: readRequestTypes) { success, error in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if success {
                let now = Date()
                let startOfDay = Calendar.current.startOfDay(for: now)
                let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
                
                let query = HKStatisticsQuery(
                    quantityType: quantityType,
                    quantitySamplePredicate: predicate,
                    options: .cumulativeSum
                ) { _, result, _ in
                    guard let result = result, let sum = result.sumQuantity() else {
                        completion(0.0)
                        return
                    }
                    print("queryHealthKit() = \(HKUnit.count())")
                    completion(sum.doubleValue(for: HKUnit.count()))
                }
                healthStore.execute(query)
            } else {
                DispatchQueue.main.async {
                    self.showHealthKitPermissionDeniedAlert {
                        completion(0.0)
                        return
                    }
                }
            }
        }
    }
    
    private func showHealthKitNotSupportedAlert(completion: (()->Void)?) {
        let title = "Health Kit"
        let message = "Apple Health is not supported on this device."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
    
    private func showHealthKitPermissionDeniedAlert(completion: (()->Void)?) {
        let title = "Health Kit"
        let message = "If you change your mind, you can enable access to Health Kit in the Settings app."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
    
}

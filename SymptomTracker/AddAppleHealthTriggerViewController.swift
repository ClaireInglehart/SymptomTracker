//
//  AddAppleHealthTriggerViewController.swift
//  SymptomTracker
//
//  Created by Mike on 3/4/22.
//

import UIKit
import HealthKit

class AddAppleHealthTriggerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var healthStore : HKHealthStore?
    //    var hk: ?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!

    public var newTriggers: [AppleHealthTrigger] = []
    
    private let availableTriggers: [AppleHealthTrigger] = [
        AppleHealthTrigger(name: "Step Count", identifier: .stepCount),
        AppleHealthTrigger(name: "Distance Walking/Running", identifier: .distanceWalkingRunning),
        AppleHealthTrigger(name: "Distance Cycling", identifier: .distanceCycling),
        AppleHealthTrigger(name: "Distance Swimming", identifier: .distanceSwimming),
        AppleHealthTrigger(name: "Distance Wheelchair", identifier: .distanceWheelchair),
        AppleHealthTrigger(name: "Basal Energy Burned", identifier: .basalEnergyBurned),
        AppleHealthTrigger(name: "Active Energy Burned", identifier: .activeEnergyBurned),
        AppleHealthTrigger(name: "Flights Climbed", identifier: .flightsClimbed),
        AppleHealthTrigger(name: "Nike Fuel", identifier: .nikeFuel),
        AppleHealthTrigger(name: "Exercise Time", identifier: .appleExerciseTime),
        AppleHealthTrigger(name: "Push Count", identifier: .pushCount),
        AppleHealthTrigger(name: "Swimming Stroke Count", identifier: .swimmingStrokeCount),
        AppleHealthTrigger(name: "Distance Downhill Snow Sports", identifier: .distanceDownhillSnowSports),
        AppleHealthTrigger(name: "Stand Time", identifier: .appleStandTime),
        AppleHealthTrigger(name: "Move Time", identifier: .appleMoveTime)
    ]
                         
//    private var supportedQuantityTypes: [HKQuantityTypeIdentifier] = []    // the types available on the device
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Apple Health Trigger"
        
        self.doneButton.layer.cornerRadius = 8.0

        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancel))
        self.navigationItem.leftBarButtonItem = cancelButton
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setUpHealthKit()
    }
    
    @objc func onCancel() {
        self.performSegue(withIdentifier: "AddTriggerCanceled", sender: self)
    }
    
    func setUpHealthKit() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
        else {
            //no healthkit on this platform
            self.showHealthKitNotSupportedAlert {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "AddTriggerCanceled", sender: self)
                }
            }
        }
        var readRequestTypes:Set<HKQuantityType> = []
        for trigger in availableTriggers {
            readRequestTypes.insert(HKQuantityType.quantityType(forIdentifier: trigger.identifier)!)
        }
                
        healthStore?.requestAuthorization(toShare: nil, read: readRequestTypes) { success, error in
            if success {
                // iOS doesn't tell us which ones the user has allowed us to read. So during check-in,
                // we just attempt to read that data and, if the user hadn't granted permission,
                // it will just look like there is no data. Weird.
                
            }   else {
                self.showHealthKitPermissionDeniedAlert {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "AddTriggerCanceled", sender: self)
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

    @IBAction func onDone(_ sender: UIButton) {
        performSegue(withIdentifier: "AppleHealthTriggersAdded", sender: sender)
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
        
        return availableTriggers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let trigger = availableTriggers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
        cell.textLabel?.text = trigger.name
        cell.detailTextLabel?.text = nil
        
        if let _ = newTriggers.firstIndex(where: { t in
            return t.identifier == trigger.identifier
        }) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trigger = availableTriggers[indexPath.row]
        self.newTriggers.append(trigger)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let trigger = availableTriggers[indexPath.row]
        if let index = newTriggers.firstIndex(where: { t in
            return t.identifier == trigger.identifier
        }) {
            self.newTriggers.remove(at: index)
        }
    }

}



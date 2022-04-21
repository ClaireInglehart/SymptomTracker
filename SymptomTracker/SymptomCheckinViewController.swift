//
//  SymptomCheckinViewController.swift
//  SymptomTracker
//

import UIKit
import HealthKit
import SVProgressHUD

class SymptomCheckinViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var likertContainerView: UIView!
    var likertView: TDLikertScaleSelectorView?
    
    @IBOutlet weak var tableView: UITableView!
    
    var symptom: Symptom?
    var symptomCheckin: SymptomCheckin?
    
    var selectedCustomTrigger: CustomTrigger?
    var selectedCustomTriggerValues: CustomTriggerCheckin?
    private var symptomSeverity: Severity?
    private var customTriggerCheckins: [CustomTriggerCheckin] = []
    private var appleHealthTriggerCheckins: [AppleHealthTriggerCheckin] = []
    
    
    struct LikertViewConfig: TDSelectionBuildConfig {
        var font: UIFont? = UIFont.systemFont(ofSize: 13)
        var textColor: UIColor?  = UIColor.systemBlue
        var backgroundColorNormal: UIColor? = UIColor.clear
        var backgroundColorHighlighted: UIColor? = UIColor.lightGray
        var backgroundColorSelected: UIColor? = UIColor.systemBlue.withAlphaComponent(0.5)
        var backgroundColorHighlightedSelected: UIColor? = UIColor.lightGray
        var borderColor: UIColor? = .systemBlue
        var borderWidth: CGFloat? = 2.0
        var buttonRadius: CGFloat? = 22
        var lineColor: UIColor? = .systemBlue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let symptom = self.symptom {
            self.navigationItem.title = "Check-in for \(symptom.name)"
        }
        
        let config = LikertViewConfig()
        let likertView = TDLikertScaleSelectorView(withConfig: config)
        likertView.delegate = self
        likertView.tag = 2
        likertView.translatesAutoresizingMaskIntoConstraints = false
        self.likertContainerView.addSubview(likertView)
        NSLayoutConstraint.activate([
            likertView.leadingAnchor.constraint(equalTo: self.likertContainerView.leadingAnchor),
            likertView.trailingAnchor.constraint(equalTo: self.likertContainerView.trailingAnchor),
            likertView.topAnchor.constraint(equalTo: self.likertContainerView.topAnchor),
            likertView.bottomAnchor.constraint(equalTo: self.likertContainerView.bottomAnchor)
        ])
        self.likertView = likertView
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancel))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
        self.navigationItem.rightBarButtonItem = doneButton
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc func onCancel() {
        self.performSegue(withIdentifier: "SymptomCheckinCanceled", sender: self)
    }
    
    @objc func onDone() {
        // TODO: display an "are you sure?" alert if some triggers don't have values.
        
        guard let symptom = self.symptom else { return }
               
        if let symptomSeverity = self.symptomSeverity {
            let symptomCheckin = SymptomCheckin(symptom: symptom, severity: symptomSeverity)
            symptomCheckin.customTriggerCheckins = self.customTriggerCheckins
            symptomCheckin.appleHealthTriggerCheckins = self.appleHealthTriggerCheckins
            
            self.symptomCheckin = symptomCheckin
            
            self.performSegue(withIdentifier: "SymptomCheckinComplete", sender: self)
        } else {
            self.showErrorToast(withMessage: "Please indicate symptom severity")
        }        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addValue", let nav = segue.destination as? UINavigationController, let vc = nav.viewControllers[0] as? AddCheckinValueViewController {
            vc.customTrigger = self.selectedCustomTrigger
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let symptom = self.symptom else { return 0 }
        
        if (section == 0) {
            return symptom.customTriggers.count
        } else {
            return symptom.appleHealthTriggers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let symptom = self.symptom else { return UITableViewCell() }
        
        if (indexPath.section == 0) {
            let trigger = symptom.customTriggers[indexPath.row]
            let triggerCheckin: CustomTriggerCheckin? = self.customTriggerCheckins.first(where: { t in
                return t.trigger.name == trigger.name
            })
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
            cell.textLabel?.text = trigger.name
            if let checkin = triggerCheckin {
                cell.detailTextLabel?.text = checkin.quantity
                cell.detailTextLabel?.textColor = .label
                cell.accessoryType = .none
            } else {
                cell.detailTextLabel?.text = "Check In"
                cell.detailTextLabel?.textColor = .systemBlue
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        } else {
            let trigger = symptom.appleHealthTriggers[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
            cell.textLabel?.text = trigger.name
            let triggerCheckin: AppleHealthTriggerCheckin? = self.appleHealthTriggerCheckins.first(where: { t in
                return t.trigger.identifier == trigger.identifier
            })
            
            
            if let triggerCheckin = triggerCheckin {
                cell.detailTextLabel?.text = "\(triggerCheckin.quantity)"
                cell.detailTextLabel?.textColor = .label
                cell.accessoryType = .none
            } else {
                cell.detailTextLabel?.text = "Check In"
                
                cell.detailTextLabel?.textColor = .systemBlue
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let symptom = self.symptom else { return 0.0 }
        
        if (section == 0) {
            return symptom.customTriggers.count > 0 ? UITableView.automaticDimension : 0.0
        } else {
            return symptom.appleHealthTriggers.count > 0 ? UITableView.automaticDimension : 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        
        let symptomLabel = UILabel()
        symptomLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(symptomLabel)
        if (section == 0) {
            symptomLabel.text = "Custom Triggers"
        } else {
            symptomLabel.text = "Apple Health Triggers"
        }
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
        guard let symptom = self.symptom else { return false }
        
        if (indexPath.section == 0) {
            let customTrigger = symptom.customTriggers[indexPath.row]
            let hasCheckin = self.customTriggerCheckins.contains { checkin in
                return customTrigger.name == checkin.trigger.name
            }
            return hasCheckin ? false : true
        } else {
            let appleHealthTrigger = symptom.appleHealthTriggers[indexPath.row]
            let hasCheckin = self.appleHealthTriggerCheckins.contains { checkin in
                return appleHealthTrigger.identifier == checkin.trigger.identifier
            }
            return hasCheckin ? false : true
        }
    }
    
    @IBAction func valueAdded(_ segue: UIStoryboardSegue) {
        if let vc = segue.source as? AddCheckinValueViewController,
           let customTrigger = vc.customTrigger, let quantity = vc.newValue {
            let customTriggerCheckin = CustomTriggerCheckin(trigger: customTrigger, quantity: quantity)
            self.customTriggerCheckins.append(customTriggerCheckin)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let symptom = self.symptom else { return nil }
        
        if (indexPath.section == 0) {
            let customTrigger = symptom.customTriggers[indexPath.row]
            let hasCheckin = self.customTriggerCheckins.contains { customTriggerCheckin in
                return customTrigger.name == customTriggerCheckin.trigger.name
            }
            return hasCheckin ? nil : indexPath
        } else {
            let appleHealthTrigger = symptom.appleHealthTriggers[indexPath.row]
            let hasCheckin = self.appleHealthTriggerCheckins.contains { appleHealthTriggerCheckin in
                return appleHealthTrigger.identifier == appleHealthTriggerCheckin.trigger.identifier
            }
            return hasCheckin ? nil : indexPath
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let symptom = self.symptom else { return }
        
        // If it's a custom trigger, show a screen to prompt user to enter value
        // If it's a custom trigger, show a screen to prompt user to enter value
        
        if (indexPath.section == 0) {
            self.selectedCustomTrigger = symptom.customTriggers[indexPath.row]
            self.performSegue(withIdentifier: "addValue", sender: tableView)
            
        } else {
            let appleHealthTrigger = symptom.appleHealthTriggers[indexPath.row]
            
            self.queryHealthKit(forIdentifier: appleHealthTrigger.identifier) { quantity in
                let appleHealthTriggerCheckin = AppleHealthTriggerCheckin(trigger: appleHealthTrigger, quantity: quantity)
                self.appleHealthTriggerCheckins.append(appleHealthTriggerCheckin)
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

extension SymptomCheckinViewController: TDLikertScaleDelegate {
    func didSelect(category cat: TDSelectionCategory, tag: Int) {
        print("Question with tag \(tag) has answer \(cat.localizedName)")
        switch (cat) {
        case .none:
            self.symptomSeverity = .none
        case .mild:
            self.symptomSeverity = .mild
        case .moderate:
            self.symptomSeverity = .moderate
        case .difficult:
            self.symptomSeverity = .difficult
        case .severe:
            self.symptomSeverity = .severe
        }

    }
}

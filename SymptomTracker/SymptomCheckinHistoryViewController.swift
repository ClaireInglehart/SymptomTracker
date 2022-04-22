//
//  SymptomCheckinHistoryViewController.swift
//  SymptomTracker
//
//  Created by Claire Inglehart on 2/6/22.
//

import UIKit

class SymptomCheckinHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var symptomCheckin: SymptomCheckin?
    @IBOutlet weak var likertContainerView: UIView!
    var likertView: TDLikertScaleSelectorView?

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

        self.navigationItem.title = "History"
        
        if let symptomCheckin = symptomCheckin {
            self.navigationItem.title = symptomCheckin.symptom.name

            let config = LikertViewConfig()
            let likertView = TDLikertScaleSelectorView(withConfig: config)
            likertView.translatesAutoresizingMaskIntoConstraints = false
            self.likertContainerView.addSubview(likertView)
            NSLayoutConstraint.activate([
                likertView.leadingAnchor.constraint(equalTo: self.likertContainerView.leadingAnchor),
                likertView.trailingAnchor.constraint(equalTo: self.likertContainerView.trailingAnchor),
                likertView.topAnchor.constraint(equalTo: self.likertContainerView.topAnchor),
                likertView.bottomAnchor.constraint(equalTo: self.likertContainerView.bottomAnchor)
            ])
            likertView.isUserInteractionEnabled = false
            switch (symptomCheckin.severity) {
            case .none:
                likertView.selectCategory(.none)
            case .mild:
                likertView.selectCategory(.mild)
            case .moderate:
                likertView.selectCategory(.moderate)
            case .difficult:
                likertView.selectCategory(.difficult)
            case .severe:
                likertView.selectCategory(.severe)
            }
            self.likertView = likertView
        }
        
        

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let symptomCheckin = self.symptomCheckin else { return 0 }

        return symptomCheckin.customTriggerCheckins.count +
            symptomCheckin.appleHealthTriggerCheckins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let symptomCheckin = self.symptomCheckin else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)

        if (indexPath.row < symptomCheckin.customTriggerCheckins.count) {
            let triggerCheckin = symptomCheckin.customTriggerCheckins[indexPath.row]
            cell.textLabel?.text = triggerCheckin.trigger.name
            cell.detailTextLabel?.text = "\(triggerCheckin.quantity!) \(triggerCheckin.trigger.units)"
            return cell
        } else {
            let triggerCheckin = symptomCheckin.appleHealthTriggerCheckins[indexPath.row - symptomCheckin.customTriggerCheckins.count]
            cell.textLabel?.text = triggerCheckin.trigger.name
            cell.detailTextLabel?.text = "\(triggerCheckin.quantity)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        
        let triggersLabel = UILabel()
        triggersLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(triggersLabel)
        triggersLabel.text = "Triggers"
        triggersLabel.textColor = .white

        let triggersLabelConstraints = [
            triggersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            triggersLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0),
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

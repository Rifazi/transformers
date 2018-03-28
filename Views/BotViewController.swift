//
//  NewBotViewController.swift
//  Transformers
//
//  Created by Rifaz Iqbal on 3/27/18.
//  Copyright © 2018 Rifaz Iqbal. All rights reserved.
//

import UIKit

protocol NewTransformerProtocol {
    func addTransformer(transformer: Transformer)
}

class BotViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var decepticonButton: UIButton!
    @IBOutlet weak var autobotButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let statCell = "statIdentifier"
    
    let statTypes = ["Strength", "Intelligence", "Speed", "Endurance", "Rank", "Courage", "Firepower", "Skill"]
    
    var transformer: Transformer!
    
    @IBOutlet weak var nameField: UITextField!
    var delegate: NewTransformerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BotViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if transformer != nil {
            populateTransformer()
        }
            
        else {
            transformer = Transformer()
        }
    }

    @IBAction func decepticonAction(_ sender: Any) {
        transformer.alliance = .decepticon
        decepticonButton.alpha = 1
        autobotButton.alpha = 0.3
    }
    
    @IBAction func autobotAction(_ sender: Any) {
        transformer.alliance = .autobot
        decepticonButton.alpha = 0.3
        autobotButton.alpha = 1
    }
    
    func populateTransformer() {
        if transformer.alliance == .autobot {
            autobotAction(self)
        }
        
        else {
            decepticonAction(self)
        }
        
        tableView.reloadData()
        
        nameField.text = transformer.name
        setValueForCell(value: transformer.strength, row: 0)
        setValueForCell(value: transformer.intelligence, row: 1)
        setValueForCell(value: transformer.speed, row: 2)
        setValueForCell(value: transformer.endurance, row: 3)
        setValueForCell(value: transformer.rank, row: 4)
        setValueForCell(value: transformer.courage, row: 5)
        setValueForCell(value: transformer.firepower, row: 6)
        setValueForCell(value: transformer.skill, row: 7)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: statCell) as! StatPickerTableViewCell
        cell.nameLabel.text = statTypes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statTypes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        if (nameField.text?.isEmpty)! {
            showAlert(message: "Please name the transformer")
        }
        
        else if transformer.alliance == nil {
            showAlert(message: "Please select alliance")
        }
        
        else {
            transformer.name = nameField.text
            transformer.strength = getValueFromCell(row: 0)
            transformer.intelligence = getValueFromCell(row: 1)
            transformer.speed = getValueFromCell(row: 2)
            transformer.endurance = getValueFromCell(row: 3)
            transformer.rank = getValueFromCell(row: 4)
            transformer.courage = getValueFromCell(row: 5)
            transformer.firepower = getValueFromCell(row: 6)
            transformer.skill = getValueFromCell(row: 7)
            
            delegate?.addTransformer(transformer: transformer)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func getValueFromCell(row: Int) -> Int {
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! StatPickerTableViewCell
        let value = Int(cell.valueField.text ?? "1")
        return value ?? 1
    }
    
    func setValueForCell(value: Int, row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! StatPickerTableViewCell
        cell.valueField.text = String(value)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

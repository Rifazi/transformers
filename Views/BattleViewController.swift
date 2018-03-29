//
//  ViewController.swift
//  Transformers
//
//  Created by Rifaz Iqbal on 3/27/18.
//  Copyright © 2018 Rifaz Iqbal. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewTransformerProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var transformers = [Transformer]()
    let transformerCellIdentifier = "transformerCell"
    var transformerToEdit: Transformer?
    let editTransformerSegue = "editTransformer"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transformers = TestSkirmish.createSkirmish()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transformerToEdit = nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transformers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transformer = transformers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: transformerCellIdentifier) as! TransformerTableViewCell
        cell.setTransformer(transformer: transformer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.transformers.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transformerToEdit = transformers[indexPath.row]
        performSegue(withIdentifier: editTransformerSegue, sender: self)
    }
    
    @IBAction func battleAction(_ sender: Any) {
        let battle = Battle()
        battle.autobotsAssemble(transformers: transformers)
        
        var result = String(battle.battles) + " battle(s)\n"
        
        if battle.battles > 0 {
            
            var winnerString = ""
            var losingString = ""
            
            if let winningTeam = battle.winningTeam() {
                
                losingString = "Survivors from the losing team "
                
                winnerString += "Winning team (" + winningTeam.rawValue + "): "
                if winningTeam == .autobot {
                    
                    let winningAutobots = battle.winningAutbots + battle.survivors.filter({$0.alliance == .autobot})
                    
                    for transfromer in winningAutobots {
                        winnerString += transfromer.name + " "
                    }
                    
                    losingString += "(Decepticons): "
                    
                    let losingDecepticons = battle.winningDecepticons + battle.survivors.filter({$0.alliance == .decepticon})
                    
                    if losingDecepticons.count > 0 {
                        for transformer in battle.survivors.filter({$0.alliance == .decepticon}) {
                            losingString += transformer.name + " "
                        }
                    }
                    else {
                        losingString += "None"
                    }
                }
                else {
                    
                    let winningDecepticons = battle.winningDecepticons + battle.survivors.filter({$0.alliance == .decepticon})
                    
                    for transfromer in winningDecepticons {
                        winnerString += transfromer.name + " "
                    }
                    
                    losingString += "(Autobots): "
                    
                    let losingAutobots = battle.winningAutbots + battle.survivors.filter({$0.alliance == .autobot})
                    
                    if losingAutobots.count > 0 {
                        for transfromer in losingAutobots {
                            losingString += transfromer.name + " "
                        }
                    }
                    
                    else {
                        losingString += "None"
                    }
                }
            }
            
            else {
                losingString = "No winners left"
            }
            
            result += winnerString + "\n" + losingString
        }
        
        else {
            result = "No battles were fought"
        }
        
        let alert = UIAlertController(title: "Result", message: result, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newBotViewController = segue.destination as? BotViewController {
            if transformerToEdit != nil {
                newBotViewController.transformer = transformerToEdit
            }
            newBotViewController.delegate = self
        }
    }
    
    func addTransformer(transformer: Transformer) {
        transformers.append(transformer)
        tableView.reloadData()
    }
}


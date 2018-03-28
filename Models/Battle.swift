//
//  Battle.swift
//  Transformers
//
//  Created by Rifaz Iqbal on 3/27/18.
//  Copyright © 2018 Rifaz Iqbal. All rights reserved.
//

import UIKit

class Battle: NSObject {

    var battles = 0
    var winningAutbots = [Transformer]()
    var winningDecepticons = [Transformer]()
    var survivors = [Transformer]()
    
    func autobotsAssemble(transformers: [Transformer]) {
        
        if transformers.count > 0 {
            let sortedTransformers = sortByAllianceAndRank(transformers)
            var autobots = sortedTransformers.autobots
            var decepticons = sortedTransformers.decepticons
            
            let numberOfAutobots = autobots?.count ?? 0
            let numberOfDecepticons = decepticons?.count ?? 0
            
            let isMoreAutobots = numberOfAutobots > numberOfDecepticons
            
            if numberOfAutobots == 0 || numberOfDecepticons == 0 {
                //Someone didn't get the memo
                resetStats()
            }
            
            if numberOfAutobots != numberOfDecepticons {
                if isMoreAutobots {
                    let numberOfBenchedBots = numberOfAutobots - numberOfDecepticons
                    survivors = survivors + Array(autobots!.dropFirst(numberOfAutobots - numberOfBenchedBots))
                    autobots = Array(autobots!.dropLast(numberOfBenchedBots))
                }
                    
                else {
                    let numberOfBenchedBots = numberOfDecepticons - numberOfAutobots
                    survivors = survivors + Array(decepticons!.dropFirst(numberOfAutobots - numberOfBenchedBots))
                    decepticons = Array(decepticons!.dropLast(numberOfBenchedBots))
                }
            }
            
            //Now it's an even match. At least in number
            for (index, autobot) in autobots!.enumerated() {
                let decepticon = decepticons![index]
                if let winner = battle(transformer0: autobot, transformer1: decepticon) {
                    if winner.alliance == .autobot {
                        winningAutbots.append(winner)
                    }
                    
                    else {
                        winningDecepticons.append(winner)
                    }
                }
                battles += 1
            }
        }
            
        else {
            //Oh no! No one showed up!
            resetStats()
        }
    }
    
    func sortByAllianceAndRank(_ transformers: [Transformer]?) -> (autobots: [Transformer]?, decepticons: [Transformer]?) {
        
        //Picking sides
        var autobots = transformers?.filter {$0.alliance == .autobot}
        var decepticons = transformers?.filter {$0.alliance == .decepticon}
        
        //Sorting by descending rating
        autobots = autobots?.sorted(by: { $0.rating() > $1.rating() })
        decepticons = decepticons?.sorted(by: { $0.rating() > $1.rating() })
        
        return (autobots: autobots, decepticons: decepticons)
    }
    
    func battle(transformer0: Transformer, transformer1: Transformer) -> Transformer? {
        
        //If Optimus Prime appears
        if transformer0.isOptimusPrime() || transformer1.isOptimusPrime() {
            // Alternate dimension Optimus Prime!
            if transformer1.isOptimusPrime() || transformer1.isPredaking() {
                resetStats()
            }
            
            else {
                return [transformer0, transformer1].filter{$0.isOptimusPrime()}.first
            }
        }
        
        //If Predaking appears
        else if transformer0.isPredaking() || transformer1.isPredaking() {
            if transformer1.isPredaking() || transformer1.isOptimusPrime() {
                resetStats()
            }
            
            else {
                return [transformer0, transformer1].filter{$0.isPredaking()}.first
            }
        }
        
        //If courage > 4 && strength > 3
        if let winner = Test.ofCourage(transformer0, transformer1) {
            if winner == Test.ofStrength(transformer0, transformer1) {
                return winner
            }
        }
        
        else if let winner = Test.ofSkill(transformer0, transformer1) {
            return winner
        }
        
        else if let winner = Test.ofRating(transformer0, transformer1) {
            return winner
        }
        
        //Neither made it out alive
        return nil
    }
    
    func winningTeam() -> Alliance? {
        let numberOfAutobots = winningAutbots.count
        let numberOfDecepticons = winningDecepticons.count
        
        if numberOfAutobots == numberOfDecepticons {
            return nil
        }
        
        return numberOfAutobots > numberOfDecepticons ? .autobot : .decepticon
    }
    
    func resetStats() {
        winningAutbots = []
        winningDecepticons = []
        battles = 0
    }
}

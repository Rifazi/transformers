//
//  Transformer.swift
//  Transformers
//
//  Created by Rifaz Iqbal on 3/27/18.
//  Copyright © 2018 Rifaz Iqbal. All rights reserved.
//

import UIKit

enum Alliance: String {
    case autobot = "Autobots"
    case decepticon = "Decepticons"
}

class Transformer: NSObject {
    
    var name: String!
    var alliance: Alliance!
    
    var strength: Int = 1 {
        didSet {
            strength.restrictRange()
        }
    }
    
    var intelligence: Int = 1 {
        didSet {
            intelligence.restrictRange()
        }
    }
    
    var speed: Int = 1 {
        didSet {
            speed.restrictRange()
        }
    }
    
    var endurance: Int = 1 {
        didSet {
            endurance.restrictRange()
        }
    }
    
    var rank: Int = 1 {
        didSet {
            rank.restrictRange()
        }
    }
    
    var courage: Int = 1 {
        didSet {
            courage.restrictRange()
        }
    }
    
    var firepower: Int = 1 {
        didSet {
            firepower.restrictRange()
        }
    }
    
    var skill: Int = 1 {
        didSet {
            skill.restrictRange()
        }
    }

    func rating() -> Int {
        let rating = strength +
            intelligence +
            speed +
            endurance +
            firepower
        return rating
    }
    
    func isOptimusPrime() -> Bool {
        if name.caseInsensitiveCompare("Optimus Prime") == .orderedSame {
            return true
        }
        return false
    }
    
    func isPredaking() -> Bool {
        if name.caseInsensitiveCompare("Predaking") == .orderedSame {
            return true
        }
        return false
    }
    
    static func convertArrayToTransformer(array: [Any]) -> Transformer? {
        
        var transformer: Transformer?
        
        if let name = array[0] as? String {
            transformer = Transformer()
            
            transformer?.name = name
            
            if let alliance = array[1] as? String {
                if alliance.caseInsensitiveCompare("A") == .orderedSame {
                    transformer?.alliance = .autobot
                }
                    
                else {
                    transformer?.alliance = .decepticon
                }
            }
            
            if let strength = array[2] as? Int {
                transformer?.strength = strength
            }
            
            if let intelligence = array[3] as? Int {
                transformer?.intelligence = intelligence
            }
            
            if let speed = array[4] as? Int {
                transformer?.speed = speed
            }
            
            if let endurance = array[5] as? Int {
                transformer?.endurance = endurance
            }
            
            if let rank = array[6] as? Int {
                transformer?.rank = rank
            }
            
            if let courage = array[7] as? Int {
                transformer?.courage = courage
            }
            
            if let firepower = array[8] as? Int {
                transformer?.firepower = firepower
            }
            
            if let skill = array[9] as? Int {
                transformer?.skill = skill
            }
        }
        
        else {
            return transformer
        }
        
        return transformer
    }
}

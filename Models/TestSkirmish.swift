//
//  TestSkirmish.swift
//  Transformers
//
//  Created by Rifaz Iqbal on 3/28/18.
//  Copyright © 2018 Rifaz Iqbal. All rights reserved.
//

import UIKit

class TestSkirmish: NSObject {
    
    static func createSkirmish() -> [Transformer] {
        
        let soundwave = Transformer.convertArrayToTransformer(array:["Soundwave", "D", 8, 9, 2, 6, 7, 5, 6, 10])
        let bluestreak = Transformer.convertArrayToTransformer(array:["Bluestreak","A", 6, 6, 7, 9, 5, 2, 9, 7])
        let hubcap = Transformer.convertArrayToTransformer(array:["Hubcap", "A", 4, 4, 4, 4, 4, 4, 4, 4])
        
        let optimusPrime = Transformer()
        optimusPrime.name = "Optimus Prime"
        optimusPrime.alliance = .autobot
        optimusPrime.courage = 8
        optimusPrime.endurance = 9
        optimusPrime.firepower = 7
        optimusPrime.intelligence = 3
        optimusPrime.rank = 1
        optimusPrime.skill = 7
        optimusPrime.speed = 8
        optimusPrime.strength = 8
        optimusPrime.endurance = 5
        
        let predaking = Transformer()
        predaking.name = "Predaking"
        predaking.alliance = .autobot
        predaking.courage = 3
        predaking.endurance = 5
        predaking.firepower = 4
        predaking.intelligence = 1
        predaking.rank = 7
        predaking.skill = 5
        predaking.speed = 4
        predaking.strength = 2
        optimusPrime.endurance = 7
        
        return [hubcap!, soundwave!, bluestreak!]
    }

}

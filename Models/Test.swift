//
//  Tests.swift
//  Transformers
//
//  Created by Rifaz Iqbal on 3/27/18.
//  Copyright © 2018 Rifaz Iqbal. All rights reserved.
//

import UIKit

class Test: NSObject {
    
    static let COURAGE_POINTS = 4
    static let ATTRIBUTE_POINTS = 3
    
    static func ofCourage(_ transformer0: Transformer, _ transformer1: Transformer) -> Transformer? {
        
        if abs(transformer0.courage - transformer1.courage) >= COURAGE_POINTS {
            return transformer0.courage > transformer1.courage ? transformer0 : transformer1
        }
        
        return nil
    }
    
    static func ofStrength(_ transformer0: Transformer, _ transformer1: Transformer) -> Transformer? {
        
        if abs(transformer0.strength - transformer1.strength) >= ATTRIBUTE_POINTS {
            return transformer0.strength > transformer1.strength ? transformer0 : transformer1
        }
        return nil
    }
    
    static func ofSkill(_ transformer0: Transformer, _ transformer1: Transformer) -> Transformer? {
        
        if abs(transformer0.skill - transformer1.skill) >= ATTRIBUTE_POINTS {
            return transformer0.skill > transformer1.skill ? transformer0 : transformer1
        }
        return nil
    }
    
    static func ofRating(_ transformer0: Transformer, _ transformer1: Transformer) -> Transformer? {
        
        if transformer0.rating() == transformer1.rating() {
            return nil
        }
        
        else {
            return transformer0.rating() > transformer1.rating() ? transformer0 : transformer1
        }
    }
}

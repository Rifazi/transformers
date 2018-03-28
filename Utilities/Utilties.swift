//
//  Utilties.swift
//  Transformers
//
//  Created by Rifaz Iqbal on 3/27/18.
//  Copyright © 2018 Rifaz Iqbal. All rights reserved.
//

import UIKit

// Creating int extension restrictRange
// because we don't want the Decepticons to be too powerful. Or too weak.

extension Int {
    mutating func restrictRange() {
        if self < 1 {
            self = 1
        }
        else if self > 10 {
            self = 10
        }
    }
}

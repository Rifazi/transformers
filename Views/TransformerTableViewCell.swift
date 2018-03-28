//
//  TransformerTableViewCell.swift
//  Transformers
//
//  Created by Rifaz Iqbal on 3/27/18.
//  Copyright © 2018 Rifaz Iqbal. All rights reserved.
//

import UIKit

class TransformerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var allianceImage: UIImageView!
    
    func setTransformer(transformer: Transformer) {
        
        nameLabel.text = transformer.name
        
        if transformer.alliance == .autobot {
            allianceImage.image = UIImage(named: "Autobot")
        }
        
        else {
            allianceImage.image = UIImage(named: "Decepticon")
        }
        
        allianceImage.contentMode = .scaleAspectFit
    }
}

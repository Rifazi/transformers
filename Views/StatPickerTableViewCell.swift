//
//  StatPickerTableViewCell.swift
//  Transformers
//
//  Created by Rifaz Iqbal on 3/27/18.
//  Copyright © 2018 Rifaz Iqbal. All rights reserved.
//

import UIKit

class StatPickerTableViewCell: UITableViewCell {
    
    let picker = UIDatePicker()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueField: UITextField!

    open override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = "1"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        resignFirstResponder()
        super.setSelected(false, animated: animated)
    }
}

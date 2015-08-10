//
//  DailyTableViewCell.swift
//  Sunny Days
//
//  Created by Calvin Nisbet on 2015-08-09.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet var TempLabel: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var dayLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

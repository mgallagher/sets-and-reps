//
//  PreconfiguredWorkoutsTableViewCell.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 4/10/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit

class PreconfiguredWorkoutsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var preconfiguredWorkoutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

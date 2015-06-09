//
//  NewWorkoutTableViewCell.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 4/5/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit

class NewWorkoutTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var cellView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

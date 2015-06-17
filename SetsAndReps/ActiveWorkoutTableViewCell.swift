//
//  ActiveWorkoutTableViewCell.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 4/17/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit
import SnapKit

class ActiveWorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var weightLiftedLabelButton: UIButton!
    @IBOutlet weak var cellView: UIView!
    var completedSetButtons = [UIButton]()
    var buttonConstraintsToRemove = [Constraint]()
    let buttonSize = 57
    var setButton : UIButton {
        get {
            var setButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            setButton.backgroundColor = UIColor.whiteColor()
            setButton.layer.cornerRadius = CGFloat(buttonSize/2)
            setButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            return setButton
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func addRepButtons(numButtons: Int) {
        
        // From http://stackoverflow.com/a/29589446
        // Just a neat way of initializing an array with unique values
        completedSetButtons = (0 ..< numButtons).map { _ in self.setButton }
        
        // First button
        superview!.addSubview(completedSetButtons[0])
        
        completedSetButtons[0].snp_makeConstraints { (make) -> Void in
            self.buttonConstraintsToRemove.append(make.left.equalTo(self.cellView.snp_trailing).constraint) // Remove for animation
            make.top.equalTo(self.exerciseLabel.snp_bottom).offset(16)
            make.size.equalTo(buttonSize)
        }
        
        // Adding the rest of the buttons
        for index in 1...numButtons-1 {
            superview!.addSubview(completedSetButtons[index])
            completedSetButtons[index].snp_makeConstraints { (make) -> Void in
                self.buttonConstraintsToRemove.append(make.left.equalTo(self.cellView.snp_trailing).constraint) // Remove for animation
                make.top.equalTo(completedSetButtons[index-1].snp_top)
                make.size.equalTo(buttonSize)
            }
        }
    }
    
    func buttonAction(sender:UIButton!)
    {
        var count = sender.titleLabel!.text?.toInt()
        if count == nil {
            UIView.animateWithDuration(0.1, animations: {
                sender.backgroundColor = UIColor.tyOrangeColor()
                sender.titleLabel!.font =  UIFont(name: "Miso-Light", size: 55)
                sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                sender.setTitle(String(5), forState: .Normal)
            })
        }
        else if count < 1 {
            UIView.animateWithDuration(0.1, animations: {
                sender.setTitle(String(5), forState: .Normal)
            })
        }
        else {
            UIView.animateWithDuration(0.001, animations: {
                sender.setTitle(String(count!-1), forState: .Normal)
            })
        }
        
        }
    }


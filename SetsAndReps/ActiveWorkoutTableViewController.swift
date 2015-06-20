//
//  ActiveWorkoutTableViewController.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 4/17/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit
import SnapKit

class ActiveWorkoutTableViewController: UITableViewController, WeightUpdatedDelegate {
    
    var currentWorkout : Workout!
    let cellColorScheme = UIColor.getCellColorSchemeArray()
    let textColorScheme = UIColor.getCellTextColorSchemeArray()
    var tempIndex = NSIndexPath(forRow: -1, inSection: -1)
    var selectedIndex = -1
    var buttonsInPlace = false
    let footerHeight = CGFloat(48.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !buttonsInPlace {
            animateButtonsFromOffScreen()
        }
//        let first = NSIndexPath(forRow: 0, inSection: 0)
//        let cellToUpdate = tableView.cellForRowAtIndexPath(first) as! ActiveWorkoutTableViewCell
//        let x = cellToUpdate.completedSetButtons[0].frame.origin.x
//        cellToUpdate.completedSetButtons[0].frame.origin.x = 200
        
    }
    
    override func viewDidLayoutSubviews() {
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(currentWorkout.exercises.count)+1 // +1 for the footer cell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let exerciseCount = Int(currentWorkout.exercises.count)
        if (indexPath.row < exerciseCount)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("exercise", forIndexPath: indexPath) as! ActiveWorkoutTableViewCell
            let exerciseForCell = currentWorkout.exercises[indexPath.row] as Exercise
            cell.exerciseLabel.text = exerciseForCell.name
            cell.exerciseLabel.textColor = textColorScheme[indexPath.row % textColorScheme.count]
            cell.backgroundColor = cellColorScheme[indexPath.row % cellColorScheme.count]
            cell.addRepButtons(Int(exerciseForCell.sets.count))
            
//            let intObject = saveWorkout.weightLiftedForExercise.objectAtIndex(UInt(indexPath.row)) as! SwiftIntObject
//            let weight = intObject.weight
            cell.weightLiftedLabelButton.setTitle(String(0), forState: .Normal)
            return cell
        }
        else // For the footer cell
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("footer", forIndexPath: indexPath) as! ActiveWorkoutTableViewCell
            cell.backgroundColor = cellColorScheme[indexPath.row % cellColorScheme.count]
            return cell
        }
    }
    
    func animateButtonsFromOffScreen() {
        var delayAmnt = 0.0
        var rowDelayAmnt = 0.0
        // Only temporary! Need to update all cells as well scroll. See http://stackoverflow.com/a/20431266
        for cell in tableView.visibleCells() as! [ActiveWorkoutTableViewCell] {
            if cell.reuseIdentifier == "exercise"
            {
            // First button constraint
            cell.buttonConstraintsToRemove[0].uninstall()
            cell.completedSetButtons[0].snp_makeConstraints { (make) -> Void in
                make.leadingMargin.equalTo(cell.exerciseLabel)
            }
            UIView.animateWithDuration(0.25, delay: (delayAmnt+rowDelayAmnt), options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.view.layoutIfNeeded()
                delayAmnt += 0.1
                }, completion: {(Bool) in
            })
        
            // Add correct constraints for proper line-up of the rest of the buttons
            for index in 1...cell.completedSetButtons.count-1 {
                cell.buttonConstraintsToRemove[index].uninstall()
                cell.completedSetButtons[index].snp_makeConstraints { (make) -> Void in
                    make.left.equalTo(cell.completedSetButtons[index-1].snp_right).offset(10)
                }
                UIView.animateWithDuration(0.25, delay: (delayAmnt+rowDelayAmnt), options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.view.layoutIfNeeded()
                    delayAmnt += 0.1
                    }, completion: {(Bool) in
                })
            }
            rowDelayAmnt += 0.15 // Remove both to animate each row one by one
            delayAmnt = 0.0
            }
        }
        buttonsInPlace = true
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let exerciseCount = Int(currentWorkout.exercises.count)
        if (indexPath.row == exerciseCount)
        {
            return 100.0
        }
        else
        {
            return 200.0
        }
    }
    
    func userDidUpdateWeight(updatedCell: NSIndexPath, weightAsString: String) {
        let cellToUpdate = tableView.cellForRowAtIndexPath(updatedCell) as! ActiveWorkoutTableViewCell
        cellToUpdate.weightLiftedLabelButton.setTitle(weightAsString, forState: .Normal)
    }
    
    @IBAction func unwindToViewControllerActiveWorkout(segue: UIStoryboardSegue) {
        println("unwinding")
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: footerHeight))
        footer.backgroundColor = cellColorScheme[currentWorkout.exercises.count % cellColorScheme.count]
        let centeringBlock = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: footerHeight))

        footer.addSubview(centeringBlock)
        centeringBlock.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(200)
            make.top.equalTo(footer)
            make.bottom.equalTo(footer)
            make.centerY.equalTo(footer.snp_centerY)
            make.centerX.equalTo(footer.snp_centerX)
        }
        let checkImg = UIImage(named: "check")
        let checkButton = UIImageView(image: checkImg)
        checkButton.frame = CGRect(x: 0, y: 0, width: footerHeight, height: footerHeight)
        centeringBlock.addSubview(checkButton)
        checkButton.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(footerHeight-8)
            make.height.equalTo(footerHeight-8)
            make.right.equalTo(centeringBlock.snp_right)
            make.centerY.equalTo(centeringBlock.snp_centerY)
        }
        return footer
    }
    
   override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       // TODO: change this
       return footerHeight
   }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "updateWeightVC"
        {
            var btnPos : CGPoint = sender!.convertPoint(CGPointZero, toView: tableView)
            var indexPathForCellToUpdate: NSIndexPath = tableView.indexPathForRowAtPoint(btnPos)!
            let cellToUpdate = tableView.cellForRowAtIndexPath(indexPathForCellToUpdate) as! ActiveWorkoutTableViewCell
            let updateWeightVC = segue.destinationViewController as! WeightChangerViewController
            updateWeightVC.weightAsString = cellToUpdate.weightLiftedLabelButton.titleLabel!.text!
            updateWeightVC.cellIndexToUpdate = indexPathForCellToUpdate
            updateWeightVC.delegate = self
        }
    }

}

class FooterNibUIView: UIView {
    @IBOutlet weak var trst: UIImageView!
    @IBOutlet weak var background: UIView!
}

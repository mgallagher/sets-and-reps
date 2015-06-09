//
//  WeightChangerViewController.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 4/19/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit

protocol WeightUpdatedDelegate {
    func userDidUpdateWeight(updatedCell:NSIndexPath, weightAsString:String)
}

class WeightChangerViewController: UIViewController {

    var delegate : WeightUpdatedDelegate? = nil
    var weightAsString : String? = nil
    let weightInterval = 5
    var cellIndexToUpdate : NSIndexPath? = nil
    @IBOutlet weak var weightTextField : UITextField! = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if weightAsString != nil {
            setWeightText(weightAsString!.toInt()!)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func incrementWeight(sender: AnyObject) {
        let up = weightTextField.text.toInt()! + weightInterval
        setWeightText(up)
    }

    @IBAction func decrementWeight(sender: AnyObject) {
        let down = weightTextField.text.toInt()! - weightInterval
        setWeightText(down)
    }
    
    @IBAction func setWeightAndDismiss(sender: UIButton) {
        view.endEditing(true)
        if (delegate != nil) {
            if (weightTextField.text.isNumeric)
            {
                delegate!.userDidUpdateWeight(cellIndexToUpdate!, weightAsString: weightTextField.text!)
            }
        }
//         self.dismissViewControllerAnimated(true, completion: nil) // Storyboard unwind isn't working
        // Unwinding this vc from storyboard
    }
    
    @IBAction func didTapOutside(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func setWeightText(weightAsInt: Int) {
        weightTextField.text = String(weightAsInt)        
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let vc = segue.destinationViewController as! ActiveWorkoutTableViewController
        
//        vc.cellIndexToUpdate = self.cellIndexToUpdate
//        let cell = vc.tableView.cellForRowAtIndexPath(cellIndexToUpdate) as! ActiveWorkoutTableViewCell
//        cell.weightLiftedLabelButton.setTitle(String(weightTextField.text.toInt()!), forState: .Normal)
//        println("setting: \(String(weightTextField.text.toInt()!))")
    }


}

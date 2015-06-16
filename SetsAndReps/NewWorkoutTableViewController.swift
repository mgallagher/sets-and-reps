//
//  NewWorkoutTableViewController.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 4/5/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit
import RealmSwift

class NewWorkoutTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
		
    let headerCellLabels = ["ACTIVE WORKOUTS", "ADD WORKOUT"]
    let addWorkoutLabels = ["+ PRE-CONFIGURED"]
    
    var activeWorkoutsIsEmpty = true
    let realm = Realm()
    var allActivePlans = Plan().getActivePlans()
    var logoContainerViewVC : LogoContainerViewController?
//    var rowToAdd = (needTo: false, index: -1)
    var needToAddRow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindToViewControllerNewWorkout(segue: UIStoryboardSegue) {
        
        if let preconfiguredWorkoutVC = segue.sourceViewController as? PreconfiguredWorkoutsTableViewController
            where needToAddRow == true
        {
            self.allActivePlans = Plan().getActivePlans() // Refresh allActivePlans
            let index = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Right)
            self.tableView.endUpdates()
            needToAddRow = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headerCellLabels.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            allActivePlans = Plan().getActivePlans()
            return Int(allActivePlans.count)
        case 1:
            return addWorkoutLabels.count
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let index = UInt(indexPath.row)
        switch indexPath.section
        {
        case 0:
            if (allActivePlans.count > 0) {
                let newWorkoutCell = tableView.dequeueReusableCellWithIdentifier("NewWorkoutCell", forIndexPath: indexPath) as! NewWorkoutTableViewCell
                newWorkoutCell.label.text! = allActivePlans[Int(index)].name.uppercaseString
                return newWorkoutCell
            }
            else {
                let newWorkoutCell = tableView.dequeueReusableCellWithIdentifier("NewWorkoutCell", forIndexPath: indexPath) as! NewWorkoutTableViewCell
                newWorkoutCell.label.text = "NO ACTIVE WORKOUTS"
                newWorkoutCell.label.textColor = UIColor.tyLightBlueTextColor()
                return newWorkoutCell
            }
            
        case 1:
            let addWorkoutCell = tableView.dequeueReusableCellWithIdentifier("AddWorkoutCell", forIndexPath: indexPath) as! NewWorkoutTableViewCell
            addWorkoutCell.label.text = addWorkoutLabels[indexPath.row]
            return addWorkoutCell
            
        default:
            let blankCell = NewWorkoutTableViewCell()
            return blankCell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let vc = segue.destinationViewController as? ActiveWorkoutTableViewController
            where segue.identifier == "StartWorkout"
        {
            let path = self.tableView.indexPathForSelectedRow()!.row
            let plan = allActivePlans[Int(path)] as Plan
            vc.currentWorkout = Workout(planToCopyFrom: plan)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            () // Workout selection segue set up in storyboard
        case (1,0):
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("Preconfigured", sender: self)
            }
        case (1,1):
            ()
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let deactivate = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Deactivate") { (indexPath) -> Void in
            self.allActivePlans = Plan().getActivePlans()
//            println("deactivating \(self.allActivePlans[indexPath.1.row].name)")
            self.realm.write {
                self.allActivePlans[indexPath.1.row].isActive = false
            }
            tableView.deleteRowsAtIndexPaths([indexPath.1], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        deactivate.backgroundColor = UIColor.tyOrangeColor()
        return [deactivate]
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // Header cells
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = self.tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! NewWorkoutTableViewCell
        headerCell.label.text = headerCellLabels[section]
        
        return headerCell.contentView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 85
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

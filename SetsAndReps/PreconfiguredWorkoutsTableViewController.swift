//
//  PreconfiguredWorkoutsTableViewController.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 4/9/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit
import RealmSwift

class PreconfiguredWorkoutsTableViewController: UITableViewController {    
    
    // MARK: - Properties
    let cellIdentifier = "PreconfiguredWorkoutCell"
    let realm = Realm()
    let allPreconfiguredPlans = Plan().getPreconfiguredPlans()
    
    @IBAction func addToDB(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: There's a way to grab the size of the status bar. Use that perhaps.
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // For adding a new cell to Active Workouts with animation
        if let cell = sender as? PreconfiguredWorkoutsTableViewCell,
        newWorkoutVC = segue.destinationViewController as? NewWorkoutTableViewController
        where cell.accessoryType != .Checkmark {
            newWorkoutVC.needToAddRow = true
            let index = tableView.indexPathForCell(cell)
            let selectedPlan = allPreconfiguredPlans[index!.row] as Plan
            
            if selectedPlan.isActive == false {
                cell.accessoryType = .Checkmark
                let user = User().getUser()
                realm.write {
                    user!.activePlans.append(selectedPlan)
                    selectedPlan.isActive = true
                    selectedPlan.dateActivated = NSDate()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(allPreconfiguredPlans.count)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PreconfiguredWorkoutsTableViewCell
        cell.preconfiguredWorkoutLabel.text = allPreconfiguredPlans[indexPath.row].name
        
        if (allPreconfiguredPlans[indexPath.row].isActive) {
            cell.accessoryType = .Checkmark
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! PreconfiguredWorkoutsTableViewCell
//        selectedCell.accessoryType = .Checkmark
//        let selectedPlan = allPreconfiguredPlans[UInt(indexPath.row)] as! Plan
//        if !selectedPlan.isActive {
//            realm.transactionWithBlock()
//            {
//                selectedPlan.isActive = true
//            }
//        }
    }
    
    // Header cell
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! PreconfiguredWorkoutsTableViewCell
        headerCell.headerLabel.text = "PRECONFIGURED WORKOTUS"
        headerCell.backgroundColor = UIColor.tyLightBlueColor()
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 85
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    

}

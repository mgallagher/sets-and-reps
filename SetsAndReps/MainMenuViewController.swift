//
//  MainMenuViewController.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 3/31/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit
import RealmSwift

class MainMenuViewController: UIViewController, UITableViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var mainMenu: MainMenuTableView!
    var isFirstRun : Bool? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenu.dataSource = mainMenu
        mainMenu.delegate = self
        navigationController?.interactivePopGestureRecognizer.delegate = self
        firstRunSetup()
    }
    
    override func viewDidAppear(animated: Bool) {
        // User weight picker
        if let firstRun = isFirstRun {
            if firstRun {
                performSegueWithIdentifier("firstRunConfig", sender: self)
                isFirstRun = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch (indexPath.row) {
        case 0:
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            performSegueWithIdentifier("New Workout", sender: self)
//        case 1:
//            performSegueWithIdentifier("History", sender: self)
        default:
            ()
        }
    }
    
    // From http://stackoverflow.com/a/28919337
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(navigationController!.viewControllers.count > 1){
            return true
        }
        return false
    }
    
    func firstRunSetup() {
        let openedAppBefore = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if openedAppBefore  {
            isFirstRun = false
            println("Not first launch.")
        }
        else {
            isFirstRun = true
            println("First launch, setting NSUserDefault.")
            let initializePreconfiguredWorkouts = PreconfiguredWorkouts()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
        }
    }
    
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue) {
        if let firstRunVC = segue.sourceViewController as? FirstRunMenuViewController
        {
            let user = User()
            if (firstRunVC.weightTextField.text.isNumeric) {
                user.weight = Double(firstRunVC.weightTextField.text.toInt()!)
                println("setting user weight to: \(user.weight)")
                Realm().write{
                    Realm().add(user)
                }
            }

        }
    }
    
    //Plans - name, exercises
    //Workout - name, exercises, completed, totalReps, totalSets, totalWeight, user (or you can use backlinks)
    //Exercise - name, sets
    //Set - reps, weight
    //User - name, currentWorkout, workouts

}

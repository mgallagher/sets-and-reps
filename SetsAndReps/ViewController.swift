//
//  ViewController.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 3/24/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//
//  TO DO:
//  How to control the table view cells without UITableViewController?
//  Create header logo class, since it's persistent across all 
//  Static header logo that stays put as views change? (low priority)
//
//  Auto resizing of font?
//  Padding for logo on main menu
//  Change color and size of ambersand
//  Fix all those incorrect image size warnings

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
//   @IBOutlet weak var mainMenu: MainMenuTableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Allows back swiping gesture without the navigation bar present
        // See func gestureRecognizerShouldBegin below also
        navigationController?.interactivePopGestureRecognizer.delegate = self
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // From http://stackoverflow.com/a/28919337
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(navigationController!.viewControllers.count > 1){
            return true
        }
        return false
    }
    

}


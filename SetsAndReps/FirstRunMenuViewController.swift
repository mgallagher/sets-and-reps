//
//  FirstRunMenuViewController.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 4/24/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit
import RealmSwift

class FirstRunMenuViewController: UIViewController {

    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    @IBOutlet var unitButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Circular buttons
        unitButtons.map({ $0.layer.cornerRadius = self.buttonHeight.constant/2 })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func kgSelected(sender: UIButton) {
        selectUnit(sender, opposite: unitButtons[0])
    }
    
    @IBAction func lbSelected(sender: UIButton) {
        selectUnit(sender, opposite: unitButtons[1])
    }
    
    @IBAction func checkPressed(sender: UIButton) {
        view.endEditing(true)
        
    }
    
    func selectUnit(sender:UIButton!, opposite:UIButton!) {
        UIView.animateWithDuration(0.2, animations: {
            sender.backgroundColor = UIColor.tyOrangeColor()
            sender.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            opposite.backgroundColor = UIColor.whiteColor()
            opposite.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        })
    }

    @IBAction func didTapOutside(sender: AnyObject) {
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

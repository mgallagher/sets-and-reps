//
//  LogoContainerViewController.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 4/20/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit
import SnapKit

protocol UpdateLogoViewDelegate {
    func resizeLogoView()
}

class LogoContainerViewController: UIViewController {

    @IBOutlet weak var darkBackgroundView: UIView!
    @IBOutlet weak var darkBackgroundViewHeight: NSLayoutConstraint!
    @IBOutlet weak var darkBackgroundViewBottom: NSLayoutConstraint!
    @IBOutlet weak var setsRepsLabel: UILabel!
    @IBOutlet weak var setsRepsLabelBottom: NSLayoutConstraint!
    @IBOutlet weak var ambersandLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var ambersandLabelCenterY: NSLayoutConstraint!
    @IBOutlet weak var ambersandLabel: UILabel!
    
    var expandedConstraints : [AnyObject]? = nil
    var delegate : UpdateLogoViewDelegate? = nil
    var logoIsShrunk = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ambersandTapped(sender: AnyObject) {
        println("ambersand tapped")
    }
    
    func toggleLogoSizeChanger() {
        if (!logoIsShrunk) {
            self.view.layoutIfNeeded()
            self.expandedConstraints = darkBackgroundView.constraints()
            darkBackgroundView.removeConstraints(darkBackgroundView.constraints())
            //  println(darkBackgroundViewBottom.constant)
            
            darkBackgroundView.removeConstraint(darkBackgroundViewHeight)
            darkBackgroundView.removeConstraint(darkBackgroundViewBottom)
            setsRepsLabel.removeConstraint(setsRepsLabelBottom)
            ambersandLabel.removeConstraint(ambersandLabelCenterX)
            ambersandLabel.removeConstraint(ambersandLabelCenterY)
            
            self.darkBackgroundView.snp_makeConstraints { (make) -> Void in
                make.height.equalTo(90)
            }
            self.setsRepsLabel.snp_makeConstraints { (make) -> Void in
                make.baseline.equalTo(self.setsRepsLabel.superview!.snp_bottom)
                make.centerX.equalTo(darkBackgroundView)
                //  make.top.equalTo(darkBackgroundView.snp_top).offset(20)
            }
            
            self.ambersandLabel.snp_makeConstraints { (make) -> Void in
                make.centerX.equalTo(setsRepsLabel).offset(0)
                make.centerY.equalTo(setsRepsLabel).offset(5)
            }
            
            UIView.animateWithDuration(0.5, animations: {
                self.setsRepsLabel.transform = CGAffineTransformScale(self.setsRepsLabel.transform, 0.6, 0.6)
                self.ambersandLabel.transform = CGAffineTransformScale(self.ambersandLabel.transform, 0.6, 0.6)
                self.view.layoutIfNeeded()
            })
            self.logoIsShrunk = true
        }
        else {
            if self.expandedConstraints != nil
            {
                self.view.layoutIfNeeded()
                darkBackgroundView.removeConstraints(darkBackgroundView.constraints())
                self.darkBackgroundView.snp_remakeConstraints { (make) -> Void in
                }
                darkBackgroundView.addConstraints(self.expandedConstraints!)
                UIView.animateWithDuration(0.5, animations: {
                    self.setsRepsLabel.transform = CGAffineTransformScale(self.setsRepsLabel.transform, 1.4, 1.4)
                    self.ambersandLabel.transform = CGAffineTransformScale(self.ambersandLabel.transform, 1.4, 1.4)
                    self.view.layoutIfNeeded()
                })
            }
            self.logoIsShrunk = false
        }
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

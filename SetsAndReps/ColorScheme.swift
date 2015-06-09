//
//  ColorScheme.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 3/26/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func tyBlueColor() -> UIColor {
        return UIColor(red: 54/255, green: 56/255, blue: 146/255, alpha: 1.0)
    }
    class func tyLightBlueColor() -> UIColor {
        return UIColor(red: 227/255.0, green: 224/255.0, blue: 254/255.0, alpha: 1.0)
    }
    class func tyLightBlueTextColor() -> UIColor {
        return UIColor(red: 227/255, green: 227/255, blue: 255/255, alpha: 1.0)
    }
    class func tyCopperColor() -> UIColor {
        return UIColor(red: 200/255, green: 81/255, blue: 1/255, alpha: 1.0)
    }
    class func tyOrangeColor() -> UIColor {
        return UIColor(red: 232/255, green: 105/255, blue: 0/255, alpha: 1.0)
    }
    class func getCellColorSchemeArray() -> [UIColor] {
        return [tyBlueColor(), tyLightBlueColor(), tyCopperColor(), tyOrangeColor()]
    }
    class func getCellTextColorSchemeArray() -> [UIColor] {
        return [tyLightBlueColor(), tyBlueColor(), UIColor.whiteColor(), UIColor.whiteColor()]
    }
}

extension String {
    var isNumeric : Bool {
        get {
            if let intInput = self.toInt() {
                return true
            }
            else {
                return false
            }
        }
    }
}
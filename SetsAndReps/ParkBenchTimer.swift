//
//  ParkBenchTimer.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 4/28/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import CoreFoundation

// From http://stackoverflow.com/a/26578191
// Usage:
//
// let timer = ParkBenchTimer()
// ... a long runnig task ...
// println("The task took \(timer.stop()) seconds.")

class ParkBenchTimer {
    
    let startTime:CFAbsoluteTime
    var endTime:CFAbsoluteTime?
    
    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()
        
        return duration!
    }
    
    var duration:CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}
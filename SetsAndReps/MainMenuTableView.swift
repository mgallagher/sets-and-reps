//
//  MainMenuTableView.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 3/25/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import UIKit

class MainMenuTableView: UITableView, UITableViewDelegate, UITableViewDataSource
{

    let cellColors = UIColor.getCellColorSchemeArray()
    let mainMenuCellLabels = ["NEW WORKOUT", "HISTORY", "GRAPH", "FEEDBACK"]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainMenuCellLabels.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let newCell = tableView.dequeueReusableCellWithIdentifier("MainMenuCell", forIndexPath: indexPath) as! MainMenuCell
        newCell.menuButtonLabel.text = mainMenuCellLabels[indexPath.row]
        newCell.backgroundColor = UIColor.tyLightBlueColor()
        return newCell
    }
}

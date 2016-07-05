//
//  WorkoutTableViewController.swift
//  SCWorkout
//
//  Created by Oksana Chuiko on 6/6/16.
//  Copyright © 2016 Oksana Chuiko. All rights reserved.
//

import UIKit

class WorkoutTableViewController: UITableViewController {

    let base1 = ["Plank", "Pull-up", "One leg dead lift", "Dumbell push", "One leg squat", "Ball crunches", "Cardio"]
    let base2 = ["Plank2", "Pull-up2", "One leg dead lift2", "Dumbell push2", "One leg squat2", "Ball crunches2", "Cardio2"]
    let base3 = ["Plank3", "Pull-up3", "One leg dead lift3", "Dumbell push3", "One leg squat3", "Ball crunches3", "Cardio3"]
    let base4 = ["Plank4", "Pull-up4", "One leg dead lift4", "Dumbell push4", "One leg squat4", "Ball crunches4", "Cardio4"]
    var rows = 0

    var currentProgram : [String] = []




    override func viewDidLoad() {
        super.viewDidLoad()
        currentProgram = loadProgramForStage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutCell", forIndexPath: indexPath) as! WorkoutTableViewCell

        //TODO: change rows in section displaying
        cell.label.text = currentProgram[rows]
        rows += 1

        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }


    private func loadProgramForStage() -> [String] {

        let defaults = NSUserDefaults.standardUserDefaults()

        let programNum = defaults.integerForKey(NSUserDefaultsKeys.ProgramNumberInStage.rawValue)

        switch programNum {
        case 1:
            return base1
        case 2:
            return base2
        case 3:
            return base3
        case 4:
            return base4
        default:
            return base1
        }
    }
}

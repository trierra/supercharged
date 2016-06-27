//
//  StagesTableViewController.swift
//  SCWorkout
//
//  Created by Oksana Chuiko on 6/6/16.
//  Copyright © 2016 Oksana Chuiko. All rights reserved.
//

import UIKit

class StagesTableViewController: UITableViewController {

    let stages = ["Basic", "Hyperteophy", "Strange & Power"]
    let base1 = ["Plank", "Pull-up", "One leg dead lift", "Dumbell push", "One leg squat", "Ball crunches", "Cardio"]

    var cellDescriptors: NSMutableArray!
    var visibleRowsPerSection = [[Int]]()


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        configureTableView()

        loadCellDescriptors()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if cellDescriptors != nil {
            return cellDescriptors.count
        }
        else {
            return 0
        }

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return visibleRowsPerSection[section].count

    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(currentCellDescriptor["cellIdentifier"] as! String, forIndexPath: indexPath) as! StagesTableViewCell

        if currentCellDescriptor["cellIdentifier"] as! String == "StageCell" {
            if let primaryTitle = currentCellDescriptor["primaryTitle"] {
                cell.textLabel?.text = primaryTitle as? String
            }

            if let secondaryTitle = currentCellDescriptor["secondaryTitle"] {
                cell.detailTextLabel?.text = secondaryTitle as? String
            }
        }
//        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellTextfield" {
//            cell.textField.placeholder = currentCellDescriptor["primaryTitle"] as? String
//        }
//        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellSwitch" {
//            cell.lblSwitchLabel.text = currentCellDescriptor["primaryTitle"] as? String
//
//            let value = currentCellDescriptor["value"] as? String
//            cell.swMaritalStatus.on = (value == "true") ? true : false
//        }
//        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellValuePicker" {
//            cell.textLabel?.text = currentCellDescriptor["primaryTitle"] as? String
//        }
//        else if currentCellDescriptor["cellIdentifier"] as! String == "idCellSlider" {
//            let value = currentCellDescriptor["value"] as! String
//            cell.slExperienceLevel.value = (value as NSString).floatValue
//        }

        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Basic"

        case 1:
            return "Hypertrophy"

        default:
            return "Strength & Power"
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath)
//
//        switch currentCellDescriptor["cellIdentifier"] as! String {
//        case "idCellNormal":
//            return 60.0
//
//        case "idCellDatePicker":
//            return 270.0
//            
//        default:
            return 44.0
//        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexOfTappedRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpandable"] as! Bool == true {
            var shouldExpandAndShowSubRows = false
            if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpanded"] as! Bool == false {
                // In this case the cell should expand.
                shouldExpandAndShowSubRows = true
            }

            cellDescriptors[indexPath.section][indexOfTappedRow].setValue(shouldExpandAndShowSubRows, forKey: "isExpanded")

            for i in (indexOfTappedRow + 1)...(indexOfTappedRow + (cellDescriptors[indexPath.section][indexOfTappedRow]["additionalRows"] as! Int)) {
                cellDescriptors[indexPath.section][i].setValue(shouldExpandAndShowSubRows, forKey: "isVisible")
            }
        }

        getIndicesOfVisibleRows()
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
    }


    //MARK: Cell expanding implementation 

    func loadCellDescriptors() {
                if let path = NSBundle.mainBundle().pathForResource("StageTableCellDescriptor", ofType: "plist") {
//            if let path = NSBundle.mainBundle().pathForResource("CellDescriptor", ofType: "plist") {

            cellDescriptors = NSMutableArray(contentsOfFile: path)
            getIndicesOfVisibleRows()
            tableView.reloadData()
        }
    }

    func getIndicesOfVisibleRows() {
        visibleRowsPerSection.removeAll()

        for currentSectionCells in cellDescriptors {
            var visibleRows = [Int]()

            for row in 0...((currentSectionCells as! [[String: AnyObject]]).count - 1) {
                if currentSectionCells[row]["isVisible"] as! Bool == true {
                    visibleRows.append(row)
                }
            }

            visibleRowsPerSection.append(visibleRows)
        }
    }

    func getCellDescriptorForIndexPath(indexPath: NSIndexPath) -> [String: AnyObject] {
        let indexOfVisibleRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let cellDescriptor = cellDescriptors[indexPath.section][indexOfVisibleRow] as! [String: AnyObject]
        return cellDescriptor
    }

}

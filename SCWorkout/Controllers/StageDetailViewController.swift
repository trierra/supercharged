//
//  StageDetailViewController.swift
//  SCWorkout
//
//  Created by Oksana Chuiko on 6/13/16.
//  Copyright © 2016 Oksana Chuiko. All rights reserved.
//

import UIKit

class StageDetailViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func startStage(sender: UIBarButtonItem) {
        print("start")
        tabBarController?.selectedIndex = 1
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

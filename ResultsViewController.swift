//
//  ResultsViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/1/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // DATA PASSED FROM OTHER CONTROLLERS
    var restingHR = String()
    var postHR = String()
    var RPE = String()
    var courseSelected = String()
    var lapsSelected = String()
    
    @IBOutlet weak var testResultsLabel: UILabel!
    @IBOutlet weak var openMenuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testResultsLabel.text = "Resting HR: " + restingHR + "\nPost HR: " + postHR + "\nRPE: " + RPE + "\nCourse: " + courseSelected + "\nLaps: " + lapsSelected + "\nPerformance: " + String(predictPeakPerformance())
        
        // FOR SWREVEAL MENU:
        if self.revealViewController() != nil {
            openMenuButton.target = self.revealViewController()
            openMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // FIX: on segue from "FinishTest" the revealViewController is nil so the menu stops working
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // EQUATIONS:
    /*
    60 pushes/min
    VO2 peak (L/min) = 0.74 + 0.31(classification) + 0.003(distance covered) – 0.15(RPE), r2 = 0.73, SEE = 0.48
    L/min.
    80 pushes/min
    VO2 peak (L/min) = 1.50 + 0.0029(distance covered) - 0.16(RPE) + 0.235(classification), r2 = 0.74, SEE = 0.44
    L/min.
    */
    
    func calculateDistance() -> Double {
        print(courseSelected)
        print(lapsSelected)
        // include a series of conditional statements to convert course to distance depending on whether metric or imperial was selected in settings
        // multiply distance by laps and return that number
        return 0.0029
    }
    
    func convertRPE() -> Double{
        // take RPE string and convert to a double
        return 0.16
    }
    
    func predictPeakPerformance() -> Double {
        let distanceCovered = calculateDistance()
        let convertedRPE = convertRPE()
        let equation = 1.50 + distanceCovered - convertedRPE + 0.235
        return equation
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

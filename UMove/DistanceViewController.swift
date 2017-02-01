//
//  DistanceViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/1/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit

class DistanceViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let screenSize = UIScreen.main.bounds
    var screenWidth = Double()
    var courseSelected = String()
    var lapsSelected = String()
    var courses = ["Indoor Track (200m)", "Outdoor Track (400m)", "Collegiate/Pro Basketball Court", "High School Basketball Court"]
    var laps = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    // DATA PASSED FROM OTHER CONTROLLERS
    var restingHR = String()
    var postHR = String()
    var RPE = String()
    
    // COURSE LABEL SHOULD BE A USER DEFAULT
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var lapStepperLabel: UILabel!
    @IBAction func lapStepper(_ sender: UIStepper) {
        lapStepperLabel.text = String(sender.value)
    }
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "FinishTest", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = Double(screenSize.width) * 0.33
        print(restingHR, postHR, RPE)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // PICKERVIEW SETUP
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return courses.count
        } else {
            return laps.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return courses[row]
        } else {
            return laps[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            courseSelected = courses[row]
        } else {
            lapsSelected = laps[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

            let label = UILabel(frame: CGRect(x:0, y:0, width:screenWidth, height:44));
            label.lineBreakMode = .byWordWrapping;
            label.numberOfLines = 0;
            if component == 0 {
                label.text = courses[row]
            } else {
                label.text = laps[row]
            }
            label.sizeToFit()
            return label;
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print(courseSelected, lapsSelected)
        let navController = segue.destination as! UINavigationController
        let destination = navController.topViewController as! ResultsViewController
        destination.restingHR = restingHR
        destination.postHR = postHR
        destination.RPE = RPE
        destination.courseSelected = courseSelected
        destination.lapsSelected = lapsSelected
    }

}

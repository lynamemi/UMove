//
//  RPEViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/1/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit

class RPEViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var RPE = String()
    var RPEScale = ["6 NO EXERCTION AT ALL","7 (EXTREMELY LIGHT)","8","9 (VERY LIGHT)","10","11 (LIGHT)","12","13 (SOMEWHAT HARD)","14","15 (HARD / HEAVY)","16","17 (VERY HARD)","18","19 (EXTREMELY HARD)","20 (MAXIMAL EXERTION)"]
    // DATA PASSED FROM OTHER CONTROLLERS
    var restingHR = String()
    var postHR = String()
    
    @IBOutlet weak var RPEPickerView: UIPickerView!
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Distance", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        RPEPickerView.delegate = self
        RPEPickerView.dataSource = self
        print(restingHR, postHR)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // PICKERVIEW SETUP
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RPEScale.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return RPEScale[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        RPE = RPEScale[row]
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print(RPE)
        let destination = segue.destination as! DistanceViewController
        destination.restingHR = restingHR
        destination.postHR = postHR
        destination.RPE = RPE
    }

}

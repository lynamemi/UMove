//
//  RestingHRViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/1/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit

class RestingHRViewController: UIViewController {
    
    var restingHR = String()
    
    @IBOutlet weak var restingHRTextField: UITextField!
    
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        textFieldSubmissionTriggered()
    }
    @IBAction func submitHeartRateButtonPressed(_ sender: UIButton) {
        textFieldSubmissionTriggered()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldSubmissionTriggered() {
        restingHR = restingHRTextField.text!
        performSegue(withIdentifier: "Start", sender: self)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! StartViewController
        destination.restingHR = restingHR
    }

}

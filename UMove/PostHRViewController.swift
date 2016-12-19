//
//  PostHRViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/1/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit

class PostHRViewController: UIViewController {
    
    var postHR = String()
    // DATA PASSED FROM OTHER CONTROLLERS
    var restingHR = String()

    @IBOutlet weak var postHRTextField: UITextField!
    
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        textFieldSubmission()
    }
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        textFieldSubmission()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(restingHR)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldSubmission() {
        postHR = postHRTextField.text!
        performSegue(withIdentifier: "RPE", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print(postHR)
        let destination = segue.destination as! RPEViewController
        destination.restingHR = restingHR
        destination.postHR = postHR
    }

}

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
    var numberOfBeats = String()
    
    @IBOutlet weak var restingHRTextField: UITextField!
    @IBOutlet weak var bottomConstraintForMainStackView: NSLayoutConstraint!
    
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        textFieldSubmissionTriggered()
    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        textFieldSubmissionTriggered()
    }

    @IBAction func takePulseButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "TakePulse", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    // MARK: - Keyboard - second answer:  http://stackoverflow.com/questions/25693130/move-textfield-when-keyboard-appears-swift?rq=1
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.bottomConstraintForMainStackView?.constant = 0.0
            } else {
                self.bottomConstraintForMainStackView?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    func textFieldSubmissionTriggered() {
        restingHR = restingHRTextField.text!
        performSegue(withIdentifier: "Start", sender: self)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Start" {
            let destination = segue.destination as! StartViewController
            destination.restingHR = restingHR
        } else {
            print("pulse taken")
        }

    }

}

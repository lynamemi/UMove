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
    var timerCount = 15
    var timer = Timer()
    
    @IBOutlet weak var restingHRTextField: UITextField!
    @IBOutlet weak var enterRestingHRLabel: UILabel!
    @IBOutlet weak var bottomConstraintForMainStackView: NSLayoutConstraint!
    
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        textFieldSubmissionTriggered()
    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        textFieldSubmissionTriggered()
    }

    @IBAction func takePulseButtonPressed(_ sender: Any) {
        //Show an alert that tells the user that the timer will be starting and they will be counting along with it.
        timer.invalidate()
        let alert = UIAlertController(title: "Find your pulse!", message: "When you press OK, the timer will start automatically. Count the beats of your pulse for the timer's duration", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.startTimer()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated:true, completion: nil)
    }
    
    func startTimer() {
        self.timerCount = 15
        self.enterRestingHRLabel.text = String(self.timerCount)
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (Timer) in
            self.connectTimer()
        })
    }
    
    func connectTimer() {
        if timerCount > 0 {
            timerCount -= 1
            enterRestingHRLabel.text = String(timerCount)
        } else {
            timer.invalidate()
            enterRestingHRLabel.text = "Enter number of pulse beats counted, we'll do the rest"
            enterRestingHRLabel.font = enterRestingHRLabel.font.withSize(24)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
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

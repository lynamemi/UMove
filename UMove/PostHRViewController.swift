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
    var timer = Timer()
    var timerCount = 15
    var numberOfBeats = String()
    
    // NEED TO USE NSUSERDEFAULTS TO CHANGE LABEL FROM TIMER TO TITLE, ETC.

    @IBOutlet weak var timerOrTitleLabel: UILabel!
    @IBOutlet weak var postHRTextField: UITextField!
    @IBOutlet weak var bottomConstraintForMainStackView: NSLayoutConstraint!
    
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        textFieldSubmission()
    }
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        textFieldSubmission()
    }
    @IBAction func retakePulseButtonPressed(_ sender: UIButton) {
        timer.invalidate()
        let alert = UIAlertController(title: "Find your pulse!", message: "When you press OK, the timer will restart automatically. Count the beats of your pulse for the timer's duration", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.startTimer()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated:true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // for timer:
        startTimer()
        
        // for keyboard:
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        self.timerCount = 15
        self.timerOrTitleLabel.text = String(self.timerCount)
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (Timer) in
            self.connectTimer()
        })
    }
    
    func connectTimer() {
        if timerCount > 0 {
            timerCount -= 1
            timerOrTitleLabel.text = String(timerCount)
        } else {
            timer.invalidate()
            timerOrTitleLabel.text = "Enter number of pulse beats counted, we'll do the rest"
            timerOrTitleLabel.font = timerOrTitleLabel.font.withSize(24)
        }
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
    
    func textFieldSubmission() {
        if let newPostHR = Int(postHRTextField.text!){
            postHR = String(newPostHR*4)
        }
        performSegue(withIdentifier: "RPE", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print(postHR)
        if segue.identifier == "RPE" {
            let destination = segue.destination as! RPEViewController
            destination.restingHR = restingHR
            destination.postHR = postHR
        }

    }

}

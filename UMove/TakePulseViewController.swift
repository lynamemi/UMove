//
//  TakePulseViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/21/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit

class TakePulseViewController: UIViewController {
    
    var timer = Timer()
    var timerCount = 15
    var numberOfBeats = String()
    
    @IBOutlet weak var numberOfBeatsEntered: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBAction func startTimerButtonPressed(_ sender: UIButton) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true, block: { (Timer) in
            self.connectTimer()
        })
    }
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        numberOfBeats = numberOfBeatsEntered.text!
        // calculate pulse and put that number in the text field on the enter resting hr page to be passed onto the next page
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func connectTimer() {
        if timerCount > 0 {
            timerCount -= 1
            timerLabel.text = String(timerCount)
        } else {
            timer.invalidate()
        }
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

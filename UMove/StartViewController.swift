//
//  StartViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/1/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    var timer = Timer()
    var timerCount = 5
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBAction func startButtonPressed(_ sender: UIButton) {
        startButton.isHidden = true
        timerLabel.isHidden = false
        timerLabel.text = String(timerCount)
        // use timer to countdown 5-4-3-2-1
        // when countdown hits 0, start official timer
        // when timer hits 0, segue to post-workout heart rate form
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.connectTimer()
        })
    }
    
    func connectTimer() {
        if timerCount > 0 {
            timerCount -= 1
            timerLabel.text = String(timerCount)
            print(timerCount)
        } else {
            timer.invalidate()
            performSegue(withIdentifier: "PostHR", sender: self)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timerLabel.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

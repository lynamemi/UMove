//
//  GetReadyHRViewController.swift
//  UMove
//
//  Created by Emily Lynam on 1/3/17.
//  Copyright © 2017 University of Montana. All rights reserved.
//

import UIKit

class GetReadyHRViewController: UIViewController {

    var timer = Timer()
    var timerCount = 5
    var restingHR = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true, block: { (Timer) in
//            self.connectTimer()
//        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timerCount = 5
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (Timer) in
            self.connectTimer()
        })
    }
    
    func connectTimer() {
        if timerCount > 0 {
            timerCount -= 1
        } else {
            timer.invalidate()
            performSegue(withIdentifier: "PostHR", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PostHRViewController
        destination.restingHR = restingHR
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

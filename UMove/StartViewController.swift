//
//  StartViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/1/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit; import AVFoundation

class StartViewController: UIViewController {
    
    var metronome = AVAudioPlayer()
    var timer = Timer()
    var timerCount = 5
    var restingHR = String()
    var timerIsInTestMode = true
    let flashingColor = UIColor(red: 0/255, green: 102/255, blue: 102/255, alpha: 1.0)
    
    @IBOutlet weak var secondSubView: UIView!
    @IBOutlet weak var firstSubView: UIView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBAction func startButtonPressed(_ sender: UIButton) {
        startButton.isHidden = true
        timerLabel.isHidden = false
        timerLabel.text = String(timerCount)
        startLabel.text = "GET READY!"
        startMetronome()
        // use timer to countdown 5-4-3-2-1
        // when countdown hits 0, start official timer
        // when timer hits 0, segue to post-workout heart rate form
        timer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true, block: { (Timer) in
            self.connectTimer()
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.isHidden = true
        print(restingHR)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func connectTimer() {
        if timerCount > 0 {
            timerCount -= 1
            timerLabel.text = String(timerCount)

            // CHANGING BACKGROUND COLOR TO THE BEAT OF THE METRONOME
            if timerCount % 2 == 0 {
                self.view.backgroundColor = flashingColor
                firstSubView.backgroundColor = flashingColor
                secondSubView.backgroundColor = flashingColor
                timerLabel.textColor = UIColor.white
                startLabel.textColor = UIColor.white
            }
            if timerCount % 2 != 0 {
                self.view.backgroundColor = UIColor.white
                firstSubView.backgroundColor = UIColor.white
                secondSubView.backgroundColor = UIColor.white
                timerLabel.textColor = UIColor.black
                startLabel.textColor = UIColor.black
            }
        } else if timerCount == 0 && timerIsInTestMode == true {
            startLabel.text = "GO!"
            startLabel.font = startLabel.font.withSize(100)
            timerCount = 6
            timerLabel.text = String(timerCount)
            timerIsInTestMode = false
        } else if timerCount == 0 && timerIsInTestMode == false {
            timer.invalidate()
            performSegue(withIdentifier: "PostHR", sender: self)
            metronome.stop()
        }
    }
    
    func startMetronome() {
        if let asset = NSDataAsset(name: "080_bpm") {
            do {
                try metronome = AVAudioPlayer(data: asset.data, fileTypeHint: "mp3")
                metronome.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! PostHRViewController
        destination.restingHR = restingHR
    }

}

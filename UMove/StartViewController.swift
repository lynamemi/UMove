//
//  StartViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/1/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit; import AVFoundation

class StartViewController: UIViewController {
    
    var restingHR = String()
    var metronome = AVAudioPlayer()
    var timeTrackerTimer = Timer()
    var metronomeTimer = Timer()
    var metronomeTimerCount = 5
    var timeTrackerCount = 9
    var timerIsInTestMode = true
    var playStatus = false
    let flashingColor = UIColor(red: 0/255, green: 102/255, blue: 102/255, alpha: 1.0)
    let secondStartButton = UIButton()
    var startLabelBeforePause = String()
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var secondSubView: UIView!
    @IBOutlet weak var firstSubView: UIView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBAction func startButtonPressed(_ sender: UIButton) {
        if startButton.currentImage == #imageLiteral(resourceName: "play_512"){
            playFitnessTest()
        } else if startButton.currentImage == #imageLiteral(resourceName: "stop_512") {
            playStatus = false
            metronomeTimer.invalidate()
            timeTrackerTimer.invalidate()
            metronome.stop()
            startLabelBeforePause = startLabel.text!

            startLabel.font = startLabel.font.withSize(18)
            startLabel.text = "Hit REFRESH to start from the beginning or PLAY to pick up where you left off"
            startButton.setImage(#imageLiteral(resourceName: "refresh_512"), for: .normal)
            // ADDING SECOND START BUTTON ONLY IF IT DOESN'T ALREADY EXIST:
            if mainStackView.subviews.count < 5 {
                secondStartButton.setImage(#imageLiteral(resourceName: "play_512"), for: .normal)
                secondStartButton.addTarget(self, action: #selector(secondStartButtonPressed), for: .touchUpInside)
                buttonStackView.addArrangedSubview(secondStartButton)
                
                // SET BUTTON COMPRESSION RESISTANCE
                secondStartButton.setContentCompressionResistancePriority(251, for: .horizontal)
                secondStartButton.setContentCompressionResistancePriority(251, for: .vertical)
                
                // SET BUTTON IMAGE ASPECT RATIO CONSTRAINT
                let buttonAspectRatioContraint = secondStartButton.heightAnchor.constraint(equalTo: secondStartButton.widthAnchor, multiplier: 1.1)
                buttonAspectRatioContraint.isActive = true
            }
        } else if startButton.currentImage == #imageLiteral(resourceName: "refresh_512") {
            startButton.setImage(#imageLiteral(resourceName: "play_512"), for: .normal)
            buttonStackView.removeArrangedSubview(secondStartButton)
            secondStartButton.removeFromSuperview()
            resetFitnessTest()
        }
    }
    @IBAction func secondStartButtonPressed(_ sender: UIButton) {
        mainStackView.removeArrangedSubview(secondStartButton)
        secondStartButton.removeFromSuperview()
        if startLabelBeforePause == "GO!" {
            startLabel.font = startLabel.font.withSize(100)
//            startLabel.adjustsFontSizeToFitWidth = true
//            startLabel.minimumScaleFactor = 0.2
        } else {
            startLabel.font = startLabel.font.withSize(42)
        }
        if timerIsInTestMode == false {
            timeTrackerTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (Timer) in
                self.connectTimer()
            })
        }
        playFitnessTest()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        resetFitnessTest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // RUN THIS FUNCTION BEFORE ANY FITNESS TEST STARTS FROM THE BEGINNING
    func resetFitnessTest() {
        startLabel.font = startLabel.font.withSize(42)
        startLabel.text = "PUSH PLAY TO START"
        timerLabel.isHidden = true
        timeLeftLabel.isHidden = true
        metronomeTimerCount = 5
        timeTrackerCount = 9
        timerIsInTestMode = true
        playStatus = false
    }
    
    // RUN THIS FUNCTION TO RESUME OR START FITNESS TEST AT ANY POINT
    func playFitnessTest() {
        playStatus = true
        startButton.setImage(#imageLiteral(resourceName: "stop_512"), for: .normal)
        timerLabel.isHidden = false
        if timerIsInTestMode == true {
            timerLabel.text = String(metronomeTimerCount)
            startLabel.text = "GET READY!"
            startLabel.font = startLabel.font.withSize(42)
        } else {
            startLabel.text = startLabelBeforePause
        }
        startMetronome()
        metronomeTimer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true, block: { (Timer) in
            self.connectMetronomeTimer()
        })
    }
    
    func connectMetronomeTimer() {
        if metronomeTimerCount > 0 && timerIsInTestMode == true {
            metronomeTimerCount -= 1
            timerLabel.text = String(metronomeTimerCount)
            changeBackgroundColorToBeat()
        } else if metronomeTimerCount == 0 && timerIsInTestMode == true {
            startLabel.text = "GO!"
            startLabel.font = startLabel.font.withSize(100)
            timeTrackerTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (Timer) in
                self.connectTimer()
            })
            metronomeTimerCount = 668
            timerLabel.text = timerToMinutes(time: TimeInterval(timeTrackerCount))
            timerLabel.textAlignment = NSTextAlignment.center
            timerIsInTestMode = false
            timeLeftLabel.isHidden = false
            timeLeftLabel.text = "TIME REMAINING:"
        } else if metronomeTimerCount > 0 && timerIsInTestMode == false {
            metronomeTimerCount -= 1
            changeBackgroundColorToBeat()
        }
    }
    
    func connectTimer() {
        if timeTrackerCount > 0 {
            timeTrackerCount -= 1
            timerLabel.text = timerToMinutes(time: TimeInterval(timeTrackerCount))
        } else if timeTrackerCount == 0 {
            timeTrackerTimer.invalidate()
            metronomeTimer.invalidate()
            performSegue(withIdentifier: "GetReadyHR", sender: self)
            metronome.stop()
        }
        if timeTrackerCount == 60 || timeTrackerCount == 120 || timeTrackerCount == 180 || timeTrackerCount == 240 {
            startLabel.text = timerToMinutes(time: TimeInterval(timeTrackerCount)) + " MINUTE WARNING"
            startLabel.font = startLabel.font.withSize(42)
        }
        if timeTrackerCount == 30 {
            startLabel.text = String(timeTrackerCount) + " SECOND WARNING"
        }
    }
    
    func timerToMinutes(time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%2i:%02i", minutes, seconds)
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
    
    func changeBackgroundColorToBeat() {
        if metronomeTimerCount % 2 == 0 {
            self.view.backgroundColor = flashingColor
//            firstSubView.backgroundColor = flashingColor
//            secondSubView.backgroundColor = flashingColor
            timerLabel.textColor = UIColor.white
            startLabel.textColor = UIColor.white
            timeLeftLabel.textColor = UIColor.white
        }
        if metronomeTimerCount % 2 != 0 {
            self.view.backgroundColor = UIColor.white
//            firstSubView.backgroundColor = UIColor.white
//            secondSubView.backgroundColor = UIColor.white
            timerLabel.textColor = UIColor.black
            startLabel.textColor = UIColor.black
            timeLeftLabel.textColor = UIColor.black
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! GetReadyHRViewController
        destination.restingHR = restingHR
    }
    
    // STOP THE METRONOME AND TIMER IF THE USER HITS THE BACK BUTTON:
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        if parent == nil && playStatus == true {
            metronomeTimer.invalidate()
            timeTrackerTimer.invalidate()
            metronome.stop()
        }
    }

}

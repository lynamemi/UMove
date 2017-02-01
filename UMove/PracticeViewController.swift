//
//  PracticeViewController.swift
//  UMove
//
//  Created by Emily Lynam on 1/2/17.
//  Copyright © 2017 University of Montana. All rights reserved.
//

import UIKit; import AVFoundation

class PracticeViewController: UIViewController {
    
    var playStatus = false
    var metronome = AVAudioPlayer()
    var timer = Timer()
    var timerCount = 0
    let flashingColor = UIColor(red: 0/255, green: 102/255, blue: 102/255, alpha: 1.0)
    
    @IBOutlet weak var practiceDescriptionLabel: UILabel!
//    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playStopButton: UIButton!
    @IBOutlet weak var pushPlayStopLabel: UILabel!

    @IBAction func playStopButtonPressed(_ sender: UIButton) {
        if playStopButton.currentImage == #imageLiteral(resourceName: "play_512"){
            playStatus = true
            playStopButton.setImage(#imageLiteral(resourceName: "stop_512"), for: .normal)
            pushPlayStopLabel.text = "PUSH STOP TO END"
            practiceDescriptionLabel.isHidden = true
            
            // start metronome
            timerCount = 1
//            timerLabel.text = String(timerCount)
            
            startMetronome()
            timer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true, block: { (Timer) in
                self.connectTimer()
            })
            
            changeBackgroundColorToBeat()

        } else if playStopButton.currentImage == #imageLiteral(resourceName: "stop_512") {
            practiceDescriptionLabel.isHidden = true
            timer.invalidate()
            metronome.stop()
            playStatus = false
            playStopButton.setImage(#imageLiteral(resourceName: "play_512"), for: .normal)
            pushPlayStopLabel.text = "PUSH PLAY TO START"
            // stop metronome
        }
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
        if playStatus == true || timerCount == 0 {
            timerCount += 1
//            timerLabel.text = String(timerCount)
            changeBackgroundColorToBeat()
        } else {
            timer.invalidate()
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
    
    func changeBackgroundColorToBeat() {
        if timerCount % 2 != 0 {
            self.view.backgroundColor = flashingColor
//            timerLabel.textColor = UIColor.white
            pushPlayStopLabel.textColor = UIColor.white
        }
        if timerCount % 2 == 0 {
            self.view.backgroundColor = UIColor.white
//            timerLabel.textColor = UIColor.black
            pushPlayStopLabel.textColor = UIColor.black
        }
    }
    
    // STOP THE METRONOME AND TIMER IF THE USER HITS THE BACK BUTTON:
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        if parent == nil && playStatus == true {
            timer.invalidate()
            metronome.stop()
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

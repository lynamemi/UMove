//
//  InstructionsViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/20/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    @IBOutlet weak var openMenuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // FOR SWREVEAL MENU:
        if self.revealViewController() != nil {
            openMenuButton.target = self.revealViewController()
            openMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
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

//
//  ViewController.swift
//  UMove
//
//  Created by Emily Lynam on 10/29/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var openMenuButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // FOR SWREVEAL MENU:
        openMenuButton.target = self.revealViewController()
        openMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


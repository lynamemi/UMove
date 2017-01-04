//
//  ViewController.swift
//  UMove
//
//  Created by Emily Lynam on 10/29/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var openMenuButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        printFonts()
        // FOR SWREVEAL MENU:
        if self.revealViewController() != nil {
            openMenuButton.target = self.revealViewController()
            openMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        performSegue(withIdentifier: "Landing", sender: self)
    }

    // run this function on viewdidload to determine the exact names of fonts to use
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


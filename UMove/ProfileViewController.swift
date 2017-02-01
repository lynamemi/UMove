//
//  ProfileViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/20/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit; import Eureka

class ProfileViewController: FormViewController {

    var courseOptions = [[String: String]]()
    var courseOptionsForRow = String()
    let maroon = UIColor(red: 94/255, green: 0, blue: 29/255, alpha: 1)
    
    @IBOutlet weak var openMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // FOR SWREVEAL MENU:
        if self.revealViewController() != nil {
            openMenuButton.target = self.revealViewController()
            openMenuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // FOR FORM - EUREKA COCOAPOD
        form = Section("Demographics")
            <<< TextRow(){ row in
                row.title = "First Name"
                row.placeholder = "Enter name here"
            }
            <<< TextRow(){ row in
                row.title = "Last Name"
                row.placeholder = "Enter name here"
            }
            <<< PhoneRow(){
                $0.title = "Height"
                $0.placeholder = "And height here"
//                $0.placeholder = "And height in meters here"
            }
            <<< PhoneRow(){
                $0.title = "Weight"
                $0.placeholder = "And weight here"
//                $0.placeholder = "And weight in kilos here"

            }
            <<< DateRow(){
                $0.title = "Birthday"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
        +++ Section ("Functional Level")
            <<< PickerInlineRow<String>("Select Level") { (row : PickerInlineRow<String>) -> Void in
                row.title = row.tag
                row.options = ["1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5"]
                row.value = row.options[0]
            }
            <<< ButtonRow() {
                $0.title = "Learn more"
                }.cellUpdate { cell, row in
                    cell.textLabel?.textColor = UIColor.black
                    //                    cell.textLabel?.font = .italicSystemFont(ofSize: 17.0)
                    cell.textLabel?.textAlignment = NSTextAlignment.left
                    cell.accessoryType = UITableViewCellAccessoryType.none
                    cell.accessoryView = UIImageView.init(image: #imageLiteral(resourceName: "questionMark_128"))
                }.onCellSelection { [weak self] (cell, row) in
                    print("add function that presents functional level info")
            }
        +++ Section ("Courses")
            <<< PickerInlineRow<String>("Select Course") { (row : PickerInlineRow<String>) -> Void in
                if courseOptions.count > 0 {
                    for i in 0...courseOptions.count {
                        row.options.append(courseOptions[i]["name"]! + courseOptions[i]["distance"]!)
                    }
                } else {
                    row.options = [courseOptionsForRow]
                    
                }
                if row.options.count < 1 {
                    row.title = "No courses added"
                } else {
                    row.title = row.tag
                    row.value = row.options[0]
                }
                
                
            }
            <<< ButtonRow() {
                $0.title = "Add new course"
                }.cellUpdate { cell, row in
                    cell.textLabel?.textColor = UIColor.black
                    //                    cell.textLabel?.font = .italicSystemFont(ofSize: 17.0)
                    cell.textLabel?.textAlignment = NSTextAlignment.left
                    cell.accessoryType = UITableViewCellAccessoryType.none
                    cell.accessoryView = UIImageView.init(image: #imageLiteral(resourceName: "plusSign_128"))
                }.onCellSelection { [weak self] (cell, row) in
                    let newCourseInput = [String:String]()
                    let alertController = UIAlertController(title: "Add New Course", message: "enter course information below to add it to your profile", preferredStyle: .alert)
                    alertController.addTextField(configurationHandler: { textField in
                        textField.placeholder = "Course name"
                    })
                    alertController.addTextField(configurationHandler: { textField in
                        textField.placeholder = "Course distance"
                        textField.keyboardType = UIKeyboardType.phonePad
                    })
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    let okAction = UIAlertAction(title: "Add", style: .default
                        , handler: { (UIAlertAction) in
                            let newCourseName = alertController.textFields?[0].text
                            let newCourseDistance = alertController.textFields?[1].text
                            if (newCourseName != "" && newCourseDistance != "") {
                                self?.courseOptions.append(newCourseInput)
                                self?.courseOptionsForRow.append(newCourseName! + " " + newCourseDistance!)
                                print(self?.courseOptionsForRow)
                                //FIGURE OUT WHY THE SECTION ISN'T RELOADING WITH THE NEW INFO
                                self?.tableView?.reloadSections([0,1,2,3], with: .none)
                            } else {
                                let warningAlertController = UIAlertController(title: "Information not complete", message: "please fill out both fields", preferredStyle: .alert)
                                let okAction = UIKit.UIAlertAction(title: "OK", style: .cancel, handler: { (UIAlertAction) in
                                    self?.present(alertController, animated: true, completion: nil)
                                }
)
                                warningAlertController.addAction(okAction)
                                self?.present(warningAlertController, animated: true, completion: nil)
                            }
                            self?.tableView?.reloadData()
                            self?.tableView?.reloadSections([1,2,3], with: .fade)
                    })
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self?.present(alertController, animated: true, completion: nil)
                    
            }
            <<< ButtonRow() {
                $0.title = "Learn more"
                }.cellUpdate { cell, row in
                    cell.textLabel?.textColor = UIColor.black
                    //                    cell.textLabel?.font = .italicSystemFont(ofSize: 17.0)
                    cell.textLabel?.textAlignment = NSTextAlignment.left
                    cell.accessoryType = UITableViewCellAccessoryType.none
                    cell.accessoryView = UIImageView.init(image: #imageLiteral(resourceName: "questionMark_128"))
                }.onCellSelection { [weak self] (cell, row) in
                    print("add function that presents functional level info")
            }
        +++ Section("Units")
            <<< SwitchRow("SwitchRow") { row in      // initializer
                row.title = "Metric"
                }.onChange { row in
                    row.title = (row.value ?? false) ? "U.S. (Imperial)" : "Metric"
                    row.updateCell()
            }
        
        // Enables the navigation accessory and stops navigation when a disabled row is encountered
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

}

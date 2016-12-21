//
//  ProfileViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/20/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit; import Eureka

class ProfileViewController: FormViewController {

    @IBOutlet weak var openMenuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                $0.placeholder = "And height in inches here"
//                $0.placeholder = "And height in meters here"
            }
            <<< PhoneRow(){
                $0.title = "Weight"
                $0.placeholder = "And weight in pounds here"
//                $0.placeholder = "And weight in kilos here"
            }
            <<< DateRow(){
                $0.title = "Birthday"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
        +++ Section("Choose Units")
            <<< SwitchRow("switchRowTag"){
                $0.title = "Metric"
            }
            <<< LabelRow(){
                $0.hidden = Condition.function(["switchRowTag"], { form in
                    return !((form.rowBy(tag: "switchRowTag") as? SwitchRow)?.value ?? false)
                })
                $0.title = "Units will be in metric"
            }
//            <<< LabelRow(){
//                $0.hidden = Condition.function(["switchRowTag"], { form in
//                    return !((form.rowBy(tag: "switchRowTag") as? SwitchRow)?.value ?? false)
//                })
//                $0.title = "Units will be in imperial"
//            }
        +++ SelectableSection<ListCheckRow<String>>("Choose your Functional Level", selectionType: .singleSelection(enableDeselection: true))
    
            let functionalLevel = ["1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5"]
            for option in functionalLevel {
                form.last! <<< ListCheckRow<String>(option){ listRow in
                    listRow.title = option
                    listRow.selectableValue = option
                    listRow.value = nil
                }
            }
        
        // Enables the navigation accessory and stops navigation when a disabled row is encountered
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)

    }

}

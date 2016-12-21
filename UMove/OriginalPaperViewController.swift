//
//  OriginalPaperViewController.swift
//  UMove
//
//  Created by Emily Lynam on 12/20/16.
//  Copyright © 2016 University of Montana. All rights reserved.
//

import UIKit

class OriginalPaperViewController: UIViewController {
    
    @IBOutlet weak var pdfWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "originalPaper", ofType: "pdf")!
        let url = URLRequest(url: NSURL.fileURL(withPath: path))
        pdfWebView.loadRequest(url)
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

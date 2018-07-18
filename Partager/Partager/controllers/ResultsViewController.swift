//
//  ResultsViewController.swift
//  Partager
//
//  Created by JL on 5/25/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    var finalTxtResult = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Display the result on new screen
        resultLabel.text = finalTxtResult
        
    }// end viewDidLoad
    
    //Presenting view controller(s) by code. not using segue
    @IBAction func info_btn(_ sender: Any) {
        if let aboutVC = storyboard?.instantiateViewController(withIdentifier: "about")
        {
            present(aboutVC, animated: true, completion: nil)
        }
    }
} //end class

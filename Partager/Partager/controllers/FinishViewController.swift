//
//  FinishViewController.swift
//  Partager
//
//  Created by JL on 5/26/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   //How to pop up a view controller to take us back to home screen
    
    //1 create an IBAction
   
    @IBAction func returnBack_btn(_ sender: Any) {
        
        //2, create a navigational control property
        if let myNavController =  navigationController {
            myNavController.popToRootViewController(animated: true)
        }
    }
    
}

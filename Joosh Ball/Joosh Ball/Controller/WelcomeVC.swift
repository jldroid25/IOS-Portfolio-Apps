//
//  ViewController.swift
//  Joosh Ball
//
//  Created by JL on 4/20/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //Position items programaticaly  in the same x & Y location for all type of devices.
        
        //-------This is not recommended Apple recommended to use AutoLayout Constrait system.
//        
//        //Center the the Swooth Logo
//        Swoosh.frame = CGRect(x: view.frame.size.width / 2 - Swoosh.frame.size.width / 2, y: 50, width: Swoosh.frame.size.width, height: Swoosh.frame.size.height)
//        
//        //Center the background Image for all devices
//        BgImg.frame = view.frame
        
    }
    
    /*
     Adding a custom back button function to unwind from current screen to previous one using an arrow image.
     Just attached to the view-controller's exit
     3rd button top to return to home screen.
     Or ctrl + drag to previous screen to go back to previous screen.
     */
    
    @IBAction func unwindFromSkillVC(unwindSegue: UIStoryboardSegue){
        
    }

}


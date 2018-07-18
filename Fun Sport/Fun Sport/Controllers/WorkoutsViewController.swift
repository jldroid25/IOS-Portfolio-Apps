//
//  WorkoutsViewController.swift
//  Fun Sport
//
//  Created by JL on 6/5/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

//Create empty detail String array
var detailsArray = [String]()

class WorkoutsViewController: UIViewController {
    
    //Store our dictionary items into an String Array
    var workoutDict = [String: [String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = appBgColor
        dataSetup()
    } //end viewdidLoad
    
    
    func dataSetup()
    {
        //App Title
        self.title = "Pick Fun Sport"
        
        //Create the path for the our plist data file
        let path = Bundle.main.path(forResource: "Workouts", ofType: "plist")
        
        // Since Path is an Optional, let's unwrapp
        if let validPath = path
        {
            let dict = NSDictionary(contentsOfFile: validPath)
            
            // Since dict is an Optional, let's unwrapp
            if let validDict = dict
            {
         
        //Make a copy of the dictionary as an Array String
                workoutDict = validDict as! [String : [String]]
                
                //Create an Array for the dictionary plist data
                let titleArrays = validDict.allKeys
                
                //Second way setting UP UI
                //get all the views's subviews from a particular viewController
                
                //Create an array of the views
                let allView = view.subviews
                
                //loop through the  array
                //for singleView in allView
                for i in 0..<allView.count
                {
                    //if the singleView is a button
                    if allView[i] is UIButton
                    {
                        let btn = allView[i] as! UIButton
                        //Set the title from our plist onto the buttons
                        btn.setTitle(titleArrays[i] as? String, for: .normal)
                        btn.backgroundColor = appItemsColor
                        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                        btn.titleLabel?.font = UIFont(name: btnfont, size: 30)
                        btn.layer.cornerRadius = 5
                        btn.clipsToBounds = true
                        
                        //the Target button to take us to the workout VC
                        btn.addTarget(self, action: #selector(WorkoutsViewController.goToDetails(sender:)), for: .touchUpInside)
                    }
                }
            }
        }
    }
    
    //sender means the button that perform the click
    @objc func goToDetails(sender: UIButton)
    {
        //Send the title text label to the VC
        if let title = sender.titleLabel?.text, let array = workoutDict[title]
        {
            //Assign/copy the array into Global var Detail Array
            detailsArray = array
            
            //Take us to the details ViewController
            performSegue(withIdentifier: "details", sender: self)
        }
    }
    //Close button to unwind the Segue
    @IBAction func close(segue: UIStoryboardSegue){
    }
}

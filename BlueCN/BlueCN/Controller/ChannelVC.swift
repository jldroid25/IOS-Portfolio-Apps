//
//  ChannelVC.swift
//  BlueCN
//
//  Created by JL on 5/5/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var loginBtn: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Enlarge the channel window view by 60% of the screen view
        self.revealViewController().rearViewRevealWidth =
            self.view.frame.size.width - 60
    }
    
    //Perform segue action for the login button to show login View Controller
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }

   

}

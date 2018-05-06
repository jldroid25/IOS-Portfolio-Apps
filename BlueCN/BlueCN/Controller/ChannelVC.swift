//
//  ChannelVC.swift
//  BlueCN
//
//  Created by JL on 5/5/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Enlarge the channel window view by 60% of the screen view
        self.revealViewController().rearViewRevealWidth =
            self.view.frame.size.width - 60

        
    }

   

}

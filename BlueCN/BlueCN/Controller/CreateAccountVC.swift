//
//  CreateAccountVC.swift
//  BlueCN
//
//  Created by JL on 5/9/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //Create ACC Close btn to bing us back to channel VC
    @IBAction func closePressed(_ sender: Any) {
      performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}

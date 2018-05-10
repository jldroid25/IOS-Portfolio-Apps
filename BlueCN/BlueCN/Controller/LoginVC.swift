//
//  LoginVC.swift
//  BlueCN
//
//  Created by JL on 5/5/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    //Close the login screen
    @IBAction func closedPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //To create an Account
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    
} //end class

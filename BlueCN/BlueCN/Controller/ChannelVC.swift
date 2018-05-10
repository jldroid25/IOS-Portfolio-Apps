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
    
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    //Take us back to Channel View controller
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Enlarge the channel window view by 60% of the screen view
        self.revealViewController().rearViewRevealWidth =
            self.view.frame.size.width - 60
        
        //Add an Observer to listen to Notification(s)
        //set in CreateAcountVC regarding user registration/login status
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDatadidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    //Perform segue action for the login button to show login View Controller
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    @objc  func userDatadidChange(_ notif: Notification){
        //if we logged in change btn title to current loggin name
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
           
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else{
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
    

}

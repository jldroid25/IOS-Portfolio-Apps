//
//  CreateAccountVC.swift
//  BlueCN
//
//  Created by JL on 5/9/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
//outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    
    //Variables for user to select Image & background color
    var avatarName = "profileDefault"
    //Color: red, green, blue, Alpha
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Update the user profile with image selected
    //From AvatarPicker
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            //set the name of the avatar
            avatarName = UserDataService.instance.avatarName
        }
    }

    //Create ACC Close btn to bing us back to channel VC
    @IBAction func closePressed(_ sender: Any) {
      performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    
    @IBAction func createAccntPressed(_ sender: Any) {
        
        //check For the name
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return}
        //For the email
        guard let email = emailTxt.text, emailTxt.text != "" else { return}
        //for the password
        guard let pass = passTxt.text, passTxt.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            
                            if success {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                
                               self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
        
    }//end CreateAccountPRessed
    
    
    //for picking the avatar image
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    //For the background color
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
        
        
    }
    
    
    
} // end class

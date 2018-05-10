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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Variables for user to select Image & background color
    var avatarName = "profileDefault"
    //Color: red, green, blue, Alpha
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    //To Pick background color
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    //Update the user profile with image selected
    //From AvatarPicker
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            
            //set the name of the avatar
            avatarName = UserDataService.instance.avatarName
            
            //set the bgColor to light gray for light images
            if avatarName.contains("light") && bgColor == nil {
            userImg.backgroundColor = UIColor.lightGray
            }
        }
    }

    //Create ACC Close btn to bing us back to channel VC
    @IBAction func closePressed(_ sender: Any) {
      performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    //Create the user Account
    @IBAction func createAccntPressed(_ sender: Any) {
        //Display the spinner indicator, user to know accnt is being created
        spinner.isHidden = false
        //Let it spin
        spinner.startAnimating()
        
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
                                //Remove the spinner indicator above
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                
                               self.performSegue(withIdentifier: UNWIND, sender: nil)
                                
                                //Send out the notification throughout to indicate
                                // user registered, loging or logout
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
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
    
    //For the  randomly generated background color
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
       let r = CGFloat(arc4random_uniform(255)) / 255
       let g = CGFloat(arc4random_uniform(255)) / 255
       let b = CGFloat(arc4random_uniform(255)) / 255
       
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        //add some animation
        UIView.animate(withDuration: 0.2){
        self.userImg.backgroundColor = self.bgColor
        }
    }
    
    //Change the Textfield placeholder's text color
    func setUpView() {
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        
        //Add a tap gesture recognizer to remove the keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        //add the tap to our view
        view.addGestureRecognizer(tap)
    }
    //Dismiss the keyboard
    @objc func handleTap() {
        view.endEditing(true)
    }
    
} // end class

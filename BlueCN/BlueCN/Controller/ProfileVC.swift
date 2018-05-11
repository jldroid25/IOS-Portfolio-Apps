//
//  ProfileVC.swift
//  BlueCN
//
//  Created by JL on 5/10/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    //IBActions
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        
        //Notify other classes user data has changed
        // later on to clear the channel, chat ect
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView () {
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarName)
        
        //tap on view to close modal
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        //add the gesture recognizer
        bgView.addGestureRecognizer(closeTouch)
    }
    
    //
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

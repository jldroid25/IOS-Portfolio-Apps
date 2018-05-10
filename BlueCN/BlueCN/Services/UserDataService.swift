//
//  UserDataService.swift
//  BlueCN
//
//  Created by JL on 5/10/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    //----Variables  needed from the API
    
    //encapsulate the data with (set)
    //others can read id, but  only this file can modify id
    public private (set) var id = ""
    public private (set) var avatarColor = ""
    public private (set) var avatarName = ""
    public private (set) var  email = ""
    public private (set) var name = ""
    
    //set them
    func setUserData(id: String, color: String,
                     avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = name
        self.email = email
        self.name = name
        
    }
    
    //update the avatar name, we will need this
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
}

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
        self.avatarName = avatarName
        self.email = email
        self.name = name
        
    }
    
    //update the avatar name, we will need this
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    //returning the UI Color, to display on channelvc
    func returnUIColor(components: String) -> UIColor {
        
        //scanner to extract rgb value from color object in database
        let scanner = Scanner(string: components)
        //tell it which characters to skip
        let skipped = CharacterSet(charactersIn: "[], ")
        //start at the begining & stop at specific character
        let comma = CharacterSet(charactersIn: ",")
        //Characters to be skipped
        scanner.charactersToBeSkipped = skipped
        
        //where to state the values
        var r, g, b, a : NSString?
        
         scanner.scanUpToCharacters(from: comma, into: &r)
         scanner.scanUpToCharacters(from: comma, into: &g)
         scanner.scanUpToCharacters(from: comma, into: &b)
         scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        //Unwrapped the r, g, b, a values from optional
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        
        //Covert the value into defaultValue, & then to a CGFloat
        let rfloat = CGFloat(rUnwrapped.doubleValue)
         let gfloat = CGFloat(gUnwrapped.doubleValue)
         let bfloat = CGFloat(bUnwrapped.doubleValue)
         let afloat = CGFloat(aUnwrapped.doubleValue)
        
        //Create the new UI Color
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
    }
}

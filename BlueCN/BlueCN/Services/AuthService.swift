//
//  AuthService.swift
//  BlueCN
//
//  Created by JL on 5/9/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import Foundation
// To handle our API Data storage
class AuthService {
    
    //Singleton, to be accessible thoughout the app
    //Can only have on single instance of it
    static let instance = AuthService()
    
    //Default way to save User data
    //(use for simple primitive data strings ect , no images or password)
    let defaults = UserDefaults.standard

/*
    var isLoggedIn : Bool {
        
        get {
            return defaults.bool (fooKey: LOGGED_IN_KEY)
        }
8*/
  }

    

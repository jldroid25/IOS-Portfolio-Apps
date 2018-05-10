//
//  Constants.swift
//  BlueCN
//
//  Created by JL on 5/5/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

//URL Constant

let BASE_URL = "https://bluecn.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\( BASE_URL)user/add"

//Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

//Notification
let NOTIF_USER_DATA_DID_CHANGE  =  Notification.Name("notifUserDataChanged")

// Segue Identifiers
let TO_LOGIN = "tologin"
let TO_CREATE_ACCOUNT  = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//User Default
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers

let HEADER =  [
    "Content-Type": "application/json; charset=utf-8"
]

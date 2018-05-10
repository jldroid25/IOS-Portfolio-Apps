//
//  AuthService.swift
//  BlueCN
//
//  Created by JL on 5/9/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

// To handle our API Data storage
class AuthService {
    
    //Singleton, to be accessible thoughout the app
    //Can only have on single instance of it
    static let instance = AuthService()
    
    //Default way to save User data
    //(use for simple primitive data strings ect , no images or password)
    let defaults = UserDefaults.standard


    var isLoggedIn : Bool {
        
        get {
            return defaults.bool (forKey: LOGGED_IN_KEY)
        }
        
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
  }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    var userEmail: String {
        
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
 
    //-------Create Web Request---------------

    //Register the user
    func registerUser(email: String, password: String,
                      completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body : [String: Any] = [
            "email":lowerCaseEmail,
            "password": password
        ]
        
        //Alamofire request, this one needs a String, .responseString
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            //Error checking
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }// end Register
    
    //User Loging
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body : [String: Any] = [
            "email":lowerCaseEmail,
            "password": password
        ]
        
        //Alamofire request, this one needs JSON response  .responseJSON
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON {
            (response) in
            
            //Error checking
            if response.result.error == nil {
                
                //------Parse the response object we get back-------
                /*
                 //Parse The email object, the old way, must know how to do it
                if response.result.error == nil {
                    //If the key is a string & value is anything <String, Any>
                    if let json = response.result.value as? Dictionary<String, Any> {
                        // if the json object is user cast as a String
                        if let email = json["user"] as? String {
                            //assigned email to the userEmail itself
                            self.userEmail = email
                        }
                        //Parse the token object as well
                        if let token = json["token"] as? String {
                            self.authToken = token
                        }
                    }
                 */
                
                //Easier way to parse data with JSON, using swiftyJSON
                guard let data = response.data else { return }
            
                let json = try! JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                    //now we can log in the user
                    self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
     }
    
    // Create the user
    func createUser(name: String, email: String, avatarName: String,
                    avatarColor: String, completion: @escaping CompletionHandler) {
        
        //lowercase the email
        let lowerCaseEmail = email.lowercased()
        //Create the body of the key-value data for the http request
        let body: [String: Any] = [
            "name" : name,
            "email": email,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        //We need a header
        let header = [
            "Authorization": "Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        //Alamofire request
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json  = try! JSON(data: data)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue
            
            UserDataService.instance.setUserData(id: id, color: color,
                                avatarName: avatarName, email: email, name: name)
                completion(true)
            
            } else{
                completion(false)
                debugPrint(response.error as Any)
            }
        }
        
    }
    
} //end class

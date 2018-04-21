//
//  File.swift
//  Joosh Ball
//
//  Created by JL on 4/21/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import Foundation

/*
 Pro Tip:
 Whenever you need to work with data put in in a struct or class,
 never pass around multiple variables between view controllers.
 */


/*
 when should you use a struc?
 
 Use struct: whenever you have to create/use primitive data structures
 like String , Int Double, float ect. They much faster than class
 
 Use Class: when you have to use/create custom things or objects like a car,
 a network, some thing specific.
 */

//Player data:
struct Player {
    var desiredLeague: String!
    var selectedSkillLevel: String!
}

/*
 Remember This Pro tip:
 var myData: String! // implicit unwrapped optional
 
 USe when you can guarantee variable will have data in it before used.
 
 var myData: String? // Optional
 Use when there may or may noy be data in the variable at runtime.
 
 */

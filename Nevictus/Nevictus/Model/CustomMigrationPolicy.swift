//
//  CustomMigrationPolicy.swift
//  Nevictus
//
//  Created by JL on 7/14/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import CoreData

class CustomMigrationPolicy: NSEntityMigrationPolicy {
    
    
    //For the transformation function here
    @objc func transformNumEmployees(forNum: NSNumber) -> String {
        
        if forNum.intValue < 150 {
            return "Small Company"
        } else {
            return "Very Large"
        }
    }
}

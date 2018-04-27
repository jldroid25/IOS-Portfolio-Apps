//
//  Wage.swift
//  Window Shopper
//
//  Created by JL on 4/26/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import Foundation

//Math for the calcuations
class Wage {
    class func getHours(forWage wage: Double, andPrice price: Double) -> Int {
        return Int(ceil(price / wage))
    }
}

//
//  Product.swift
//  James Store
//
//  Created by JL on 4/28/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import Foundation

/*
 Pro tip:
 Always use a Struct unless you actually neeed a class.
 */
struct Product {
    private (set) public var title: String
    private (set) public var price: String
    private (set) public var imageName: String
    
    init(title: String, price: String, imageName: String) {
        self.title = title
        self.price = price
        self.imageName = imageName
    }
}

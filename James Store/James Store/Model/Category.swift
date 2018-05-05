//
//  Category.swift
//  James Store
//
//  Created by JL on 4/27/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import Foundation

//Store the Image data
struct Category{
    
    /* use private (set) to prevent these variable
    to be set in other classes.
    Your data class or var should always be private
    */
    private (set)var  title: String
    private (set)var imageName: String
    
    //initializer
    //This is the only place our title & image can be set
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}

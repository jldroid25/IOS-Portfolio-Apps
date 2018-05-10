//
//  CircleImage.swift
//  BlueCN
//
//  Created by JL on 5/10/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

//turn image into a circle
    override func awakeFromNib() {
        setUpView()
    }
    
    //do a full rounding of the image width
    func setUpView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

   override  func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    setUpView()
    }
}

//
//  BorderButton.swift
//  Joosh Ball
//
//  Created by JL on 4/20/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class BorderButton: UIButton {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    //Create a border button
    override func awakeFromNib() {
        /*As per apple doc always call super class
         When overriding a custom fucntion.
         */
        super.awakeFromNib()
        //access the layer property
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
    }
    
}

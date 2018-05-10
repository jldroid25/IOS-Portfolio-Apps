//
//  GradientView.swift
//  BlueCN
//
//  Created by JL on 5/9/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

//Be able to render dynamic views in our story-Board
@IBDesignable

class GradientView: UIView {
    
    //Creating the gradient color for ChannelVC
    
    //@IBInspectable Allow us to change select &
    //change variable in the storyBoard for our like colors ect.
    
    //Gradient top color
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        //Inform StoryBoard that we changed some stuff
        //Update how we look
        didSet {
            self.setNeedsLayout()
        }
    }
    
    //Gradient Bottom
    //Same as above  for bottom color with color view
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    //This is where we create or  add our layer once the color
    //changes occurs from above
    
    override func layoutSubviews() {
        //Create the GradientLayer object
        let gradientLayer = CAGradientLayer()
        //Set the colors
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        //Set the start & end point for the gradient layer
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        //set the size
        gradientLayer.frame = self.bounds
        //add it to our UI view layer, 0 for the first layer
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

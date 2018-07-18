//
//  DetailsScreenVC.swift
//  Fun Sport
//
//  Created by JL on 6/6/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class DetailsScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageUISetup()
        descriptionTxt()
        
        view.backgroundColor = appBgColor
        
    }
    
    func imageUISetup() {
        //Access the Imageview tag
        let imgView = view.viewWithTag(6) as! UIImageView
        //create the image, from the Array's index 0
        let gymImage = UIImage(named: detailsArray[0])
        imgView.image = gymImage
        //decorate the imageview
        imgView.layer.borderWidth = 4
        imgView.layer.borderColor = #colorLiteral(red: 0.527913034, green: 0.124891974, blue: 0.4402489066, alpha: 1)
    }
    
    func descriptionTxt()
    {
        //Set up the textView
        let descTxtView = view.viewWithTag(7) as! UITextView
        descTxtView.text = detailsArray[1]
        descTxtView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        descTxtView.font = UIFont(name: descFont, size: 25)
        
        //color for the close button
        let btn = view.viewWithTag(5) as! UIButton
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    }
}

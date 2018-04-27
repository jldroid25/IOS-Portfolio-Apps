//
//  CurrencyTxtField.swift
//  Window Shopper
//
//  Created by JL on 4/25/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

//Show us the changes in this class in Interface Builder as well
@IBDesignable

class CurrencyTxtField: UITextField {
    
    /*
     Using draw(_rect: CGRect) to design view label currency sign for textFields
     Never call super() on this function.
     Never call this function if it is empty it will crash the app.
     */
    override func draw(_ rect: CGRect) {
        //We have to use float not double when Drawing.
        let size: CGFloat = 20
        let currencyLbl = UILabel(frame: CGRect(x: 5, y: (frame.size.height / 2) - size / 2, width: size, height: size))
        currencyLbl.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.8048480308)
        currencyLbl.textAlignment = .center
        currencyLbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        //For Rounded coners
        currencyLbl.layer.cornerRadius = 5.0
        //must have to work with .corner radius above
        currencyLbl.clipsToBounds = true
        
        //Formatting the currency type
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        //Will auto display the right currency base on local time.
        formatter.locale = .current
        currencyLbl.text = formatter.currencySymbol
        addSubview(currencyLbl)
        
    }
    
    //For @IBDesignable to work we must pass it our defined
    //customized function
    override func prepareForInterfaceBuilder() {
       customizeView()
}
    
    //To run this code when interface build comes up.
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    //Let's grab our customized view codes
    // so we can call this function in  prepareforInterfaceBuilder.
   func customizeView(){
      //Custom classes to improve views/ UI object appearances.
    
    //Set the background color with 25% opacity
    backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2509364298)
    
    //Create rounded coners
    layer.cornerRadius = 5.0
    //Txt allign center
    textAlignment = .center
    clipsToBounds = true
    
    if let p = placeholder {
        let place = NSAttributedString(string: p,
                                       attributes: [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        attributedPlaceholder = place
        textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
   }
    
}

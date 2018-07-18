//
//  CustomButton.swift
//  Fun Sport
//
//  Created by JL on 6/5/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //Let's override the default buttons properties(colors, font ect..)
        //in Interface builder.
        
        self.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.titleLabel?.font = UIFont(name: btnfont, size: 30)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}

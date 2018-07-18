//
//  CarTableViewCell.swift
//  HotCars
//
//  Created by JL on 6/8/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var carImgview: UIImageView!
    
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //This is a bit similar to ViewDidLoad
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Customization For the Car ImageView
        carImgview.layer.cornerRadius = 10
        carImgview.clipsToBounds = true
        
        //Customization For the back hidden Label/Screen
        backLabel.layer.cornerRadius = 10
        backLabel.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        backLabel.layer.borderWidth = 3
        backLabel.clipsToBounds = true
        
        //Customization For the Number Label
        numberLabel.layer.cornerRadius = 17.5
        numberLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        numberLabel.layer.borderWidth = 3
        numberLabel.clipsToBounds = true
        
        //Customization For the Car Title Label
        titleLabel.layer.cornerRadius = 17.5
        titleLabel.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        titleLabel.layer.borderWidth = 3
        titleLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

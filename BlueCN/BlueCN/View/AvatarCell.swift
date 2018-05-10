//
//  AvatarCell.swift
//  BlueCN
//
//  Created by JL on 5/10/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

//Type of Avatar light or Dark
enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    //Prep our view to receive services
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    //configure the cell
    func configureCell(index: Int, type: AvatarType){
        //if image type is dark, pass it dark & image index
        if type == AvatarType.dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            //style it, if dark add light background to it
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    //setup our views
    func setUpView(){
    self.layer.backgroundColor = UIColor.lightGray.cgColor
    self.layer.cornerRadius = 10
    self.clipsToBounds = true
    
    }

    
    
}

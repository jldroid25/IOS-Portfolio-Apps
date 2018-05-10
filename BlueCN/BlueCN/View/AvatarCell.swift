//
//  AvatarCell.swift
//  BlueCN
//
//  Created by JL on 5/10/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    //Prep our view to receive services
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    //setup our views
    func setUpView(){
    self.layer.backgroundColor = UIColor.lightGray.cgColor
    self.layer.cornerRadius = 10
    self.clipsToBounds = true
    
    }

    
    
}

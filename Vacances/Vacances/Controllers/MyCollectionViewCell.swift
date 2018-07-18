//
//  MyCollectionViewCell.swift
//  Vacances
//
//  Created by JL on 6/29/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImgView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib(){
        
        //set up cornerradius & Imagebounds
        pictureImgView.layer.cornerRadius = 15
        pictureImgView.clipsToBounds = true
    
    }
}

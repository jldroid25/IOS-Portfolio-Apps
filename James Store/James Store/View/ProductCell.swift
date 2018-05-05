//
//  ProductCell.swift
//  James Store
//
//  Created by JL on 4/28/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit


class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    //Update our views with the appropriate data
    //when being display/recycle for the cell/row.
    
    func updateViews(product: Product){
        productImage.image = UIImage(named: product.imageName)
        productTitle.text  = product.title
        productPrice.text = product.price
    }
    
    
}

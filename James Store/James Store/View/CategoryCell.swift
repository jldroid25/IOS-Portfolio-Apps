//
//  CategoryCell.swift
//  James Store
//
//  Created by JL on 4/26/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    //for our cells
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!

//Update the views on the cell
    func updateViews(category: Category){
        categoryImage.image = UIImage(named: category.imageName)
        categoryTitle.text = category.title
    }

}

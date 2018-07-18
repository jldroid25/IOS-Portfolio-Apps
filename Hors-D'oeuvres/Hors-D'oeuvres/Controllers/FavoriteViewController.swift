//
//  FavoriteViewController.swift
//  Hors-D'oeuvres
//
//  Created by JL on 5/26/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var favoriteImgView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //background color set in global theme
        view.backgroundColor = theme
        
        //using built-in saving feature, UserDefault
        let savingDefaults = UserDefaults.standard
        
        //assign it key "...."
        let indexSaved = savingDefaults.integer(forKey: "favorites")
        
        //interpolate image name with it's integer suffix
        let imageName = "recipe\(indexSaved)"
        
        //create the image
        let image = UIImage(named: imageName)
        
        //Display the image
        favoriteImgView.image = image
        
        
        //check then set border style change
        if imageBorder
        {
            favoriteImgView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            favoriteImgView.layer.borderWidth = 5.0
        } else
        {
            favoriteImgView.layer.borderWidth = 0
        }
        
        //Add rounded corner to image border
        favoriteImgView.layer.cornerRadius = 25.0
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

    }

}

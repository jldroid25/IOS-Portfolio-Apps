//
//  FirstViewController.swift
//  Hors-D'oeuvres
//
//  Created by JL on 5/26/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

//set the default app theme outside class to be accessible.
var theme : UIColor = #colorLiteral(red: 0.3834089339, green: 0.09345621616, blue: 0.2924871445, alpha: 1)

//using built-in saving feature, UserDefault
let savingDefaults = UserDefaults.standard

//To change image Borders
var imageBorder = false

class HomeViewController: UIViewController {
    
    //Image Array
    var recipesArray = ["recipe0","recipe1","recipe2","recipe3"]
    var arrayIndex = 0

    @IBOutlet weak var recipeImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = theme
        
        //check then set border style change
        if imageBorder
        {
            recipeImageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            recipeImageView.layer.borderWidth = 5.0
        } else
        {
            recipeImageView.layer.borderWidth = 0
        }
        
        //Add rounded corner to image border
     recipeImageView.layer.cornerRadius = 25.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        if arrayIndex > 0 {
            arrayIndex -= 1
            
            //get the image from the array
            let imageName = recipesArray[arrayIndex]
            //pass in the image
            let image = UIImage(named: imageName)
            recipeImageView.image = image
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
        if arrayIndex < recipesArray.count - 1
        {
        arrayIndex += 1
        let imageName = recipesArray[arrayIndex]
        let recipesImage = UIImage(named: imageName)
        recipeImageView.image = recipesImage
        }
    }
    
    //Button to save recipes
    @IBAction func favRecipesBtn(_ sender: Any) {
        let savingDefaults = UserDefaults.standard
        savingDefaults.set(arrayIndex, forKey: "favorites")
    }
    
}// end class


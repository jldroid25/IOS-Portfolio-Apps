//
//  SettingsViewController.swift
//  Hors-D'oeuvres
//
//  Created by JL on 5/26/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = theme
        
        //To display settings the theme that were changed
        let themeValue = defaultColorChanges.integer(forKey: "theme")
        
        if themeValue  == 0
        {
            view.backgroundColor = #colorLiteral(red: 0.3834089339, green: 0.09345621616, blue: 0.2924871445, alpha: 1)
            changeTheme(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        } else {
            view.backgroundColor = #colorLiteral(red: 0.527913034, green: 0.124891974, blue: 0.4402489066, alpha: 1)

            changeTheme(color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        }
        
    }

    @IBOutlet weak var stepperFavorite: UIStepper!
    
    //change the border style - rounded/ normal
    @IBAction func switchChanged(_ sender: Any) {
        
        if switchBorder.isOn
        {
            imageBorder = true
        }
        else
        {
            imageBorder = false
        }
        
    }
    
    @IBOutlet weak var switchBorder: UISwitch!
    
    @IBOutlet weak var segmentedTheme: UISegmentedControl!
    
    //to preserve the UI setting
    let defaultColorChanges = UserDefaults.standard
    
    @IBAction func segmentedChange(_ sender: Any) {
        //the default 0 & 1 value
        let index = segmentedTheme.selectedSegmentIndex
        
        defaultColorChanges.set(index, forKey: "theme")
        
        if index == 0
        {
            theme = #colorLiteral(red: 0.3834089339, green: 0.09345621616, blue: 0.2924871445, alpha: 1)
            
            //change the label's colors upon theme change
            for label in settingLabels
            {
                label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                switchBorder.onTintColor = #colorLiteral(red: 0.527913034, green: 0.124891974, blue: 0.4402489066, alpha: 1)
                stepperFavorite.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            
        } else {
            theme = #colorLiteral(red: 0.527913034, green: 0.124891974, blue: 0.4402489066, alpha: 1)
            changeTheme(color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
        }
        view.backgroundColor = theme
    } //end segmented change
    
    @IBOutlet var settingLabels: [UILabel]!
    
    func changeTheme(color: UIColor)
    {
        //change the label's colors upon theme change
        for label in settingLabels
        {
            label.textColor = color
            switchBorder.onTintColor = color
            stepperFavorite.tintColor = color
        }
    }//end changeTheme
}

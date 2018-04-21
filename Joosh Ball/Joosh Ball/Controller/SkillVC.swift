//
//  SkillVC.swift
//  Joosh Ball
//
//  Created by JL on 4/21/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class SkillVC: UIViewController {
    
    //unwrapped optional for var, we promised there will data & not nil/empty
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testing if data is passing
        print(player.desiredLeague)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

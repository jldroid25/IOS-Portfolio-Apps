//
//  LeagueVC.swift
//  Joosh Ball
//
//  Created by JL on 4/21/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class LeagueVC: UIViewController {
    
    //Declare a Player with an implicit unwrapped optional
    var player: Player!
    
    
    /*Create a segue Programatically from one view controller to another.
     
     Note: this is different from ctrl + drag from button to viewController.
     
     note: If you had other screens you could do
     an if-Else-statement with same codes & different identifier.
     
     Why do segue programatically:
     UI Segue can't be debug with debbuger step in, through etc.
     Also some employer has stric coding standard thet wants code
     instead of interface builder.
     
     This prog segue always requires an Identifier
     */
    @IBAction func onNextTapped(_ sender: Any) {
        performSegue(withIdentifier: "skillVCSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialized the player's struct
        player = Player()
        
    }
    
    
    @IBAction func onMensTapped(_ sender: Any) {
        //select the mens league
        selectLeague(leagueType: "men")
        
    }
    
    @IBAction func onWomensTapped(_ sender: Any) {
        //Select womens league
        selectLeague(leagueType: "womens")
        
    }
    
    @IBAction func onCoedTapped(_ sender: Any) {
        //Select the coed league
        selectLeague(leagueType: "coed")
    }
    
    //function to avoid repeated codes from  IBAction
    func selectLeague(leagueType: String){
        player.desiredLeague = leagueType
        nextBtn.isEnabled = true
    }
    /* To pass data from one view controller to the next
     You must use prepare(for segue: UIStoryboardSegue, sender: any){}
     
     Also:
     Always remember:
     prepare-for-segue is always called before
     viewDidLoad (on the destination controller) if you initialized it.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //this code can also be use for multiple segues with if let & else statement.
        
        //Go grab SkillVC ViewControlle from this segue destination
        //& store it in this constant skillVC
        if let skillVC = segue.destination as? SkillVC{
            //pass data into it from leagueVC to SkillVC here.
            skillVC.player = player
        }
    }
    
    
    
    //Passing data between views, event handling
    //When the screen Loads button will disabled
    @IBOutlet weak var nextBtn: BorderButton!
    
    
}

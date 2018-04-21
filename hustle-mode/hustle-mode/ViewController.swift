//
//  ViewController.swift
//  hustle-mode
//
//  Created by JL on 4/12/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    
    @IBOutlet weak var powerBtn: UIButton!
    
    
    @IBOutlet weak var darkBlueBg: UIImageView!
    @IBOutlet weak var cloudHolder: UIView!
    @IBOutlet weak var rocket: UIImageView!
    @IBOutlet weak var hustleLbl: UILabel!
    @IBOutlet weak var onLbl: UILabel!
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Let's grab the wave file
        let path = Bundle.main.path(forResource: "hustle-on", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        
        //Prepare the player to play with a try/catch block
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch let error as NSError{
            print(error.description)
        }

    }

    @IBAction func powerBtnPressed(_ sender: Any) {
        cloudHolder.isHidden = false
        darkBlueBg.isHidden = true
        powerBtn.isHidden = true
        
        player.play() //play the sound
        
        //create a cool lift up animation for 2.3 seconds
        UIView.animate(withDuration: 2.3, animations: {
            //direction for anim, width & height same as storyboard ones.
            self.rocket.frame = CGRect(x: 0, y: 100, width: 375, height: 402)
        }){(finished) in
            self.hustleLbl.isHidden = false
            self.onLbl.isHidden = false
            
        }
        
    }
    

}


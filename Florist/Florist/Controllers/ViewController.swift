//
//  ViewController.swift
//  Florist
//
//  Created by JL on 4/17/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var sampleButton: UIButton!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    //Adding views programatically
    
    
    @IBAction func facebookClick(_ sender: Any) {
        //print("Facebook btn was clicked")
        
        topLabel.text = "Facebook Info"
        infoLabel.text = "This is our facebook data that was stollen by Cambridge analytica"
    }
    
    
    @IBAction func YoutubeClick(_ sender: Any) {
        //print("Youtube Btn was Clicked")
        
        topLabel.text = "Youtube Info"
        infoLabel.text = "This is our Youtube Channel we don't make money but it's better than  facebook . This data was stollen by Vimeo"
    }
    
    @IBAction func twitterClick(_ sender: Any) {
        
        //print("twitter was clicked")
        
        topLabel.text = "Twitter Info"
        infoLabel.text = "This is our Twitter Account where all the hot Canadian girls are, we don't make money but it's better than  facebook . This data was stollen by Google+"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topLabel.text = "Buy From us !"
        infoLabel.text = "A rose is a woody perennial flowering plant of the genus Rosa, in the family Rosaceae, or the flower it bears. There are over a hundred species and thousands of cultivars. They form a group of plants that can be erect shrubs, climbing or trailing with stems that are often armed with sharp prickles. Flowers vary in size and shape and are usually large and showy, in colours ranging from white through yellows and reds. Most species are native to Asia, with smaller numbers native to Europe, North America, and northwestern Africa. Species, cultivars and hybrids are all widely grown for their beauty and often are fragrant. Roses have acquired cultural significance in many societies. Rose plants range in size from compact, miniature roses, to climbers that can reach seven meters in height. Different species hybridize easily, and this has been used in the development of the wide range of garden roses."
    }
    
    override func viewDidLoad() {
        
        sampleButton.backgroundColor = UIColor.darkGray
        topLabel.textColor = UIColor.yellow
        
        /*
        let topUilabel = UILabel(frame: CGRect(x: 50, y: 150,
                                              width: 200, height: 50))
        topUilabel.text = "We are the best Swift florist"
        topUilabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        topUilabel.textAlignment = NSTextAlignment.center
        topUilabel.numberOfLines = 2
       // topUilabel.backgroundColor = UIColor.cyan
        topUilabel.font = UIFont(name: "AvenirNext", size: 16)
        
        //Now add the lable to the view
        self.view.addSubview(topUilabel)
 */
        
        /*
        //adding image programatically
        
        //create an ImageView Object
        let myImage = UIImageView()
        //place the image on the screen using frame property & CGREct()
        myImage.frame = CGRect(x: 40, y: 350, width: 60, height: 60)
        //Getting the image to display
        myImage.image = UIImage(named: "youtube")
        myImage.contentMode = UIViewContentMode.scaleAspectFit
        myImage.center = CGPoint(x: self.view.frame.width/2,
                                 y: self.view.frame.height / 2)
        self.view.addSubview(myImage)
 */
        
        
        
    } //end ViewdidLoad
    
}

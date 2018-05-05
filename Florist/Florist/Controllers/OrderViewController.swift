//
//  OrderViewController.swift
//  Florist
//
//  Created by JL on 5/4/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var OrderBottomBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        OrderBottomBtn.backgroundColor = UIColor.darkGray
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

//
//  ViewController.swift
//  Window Shopper
//
//  Created by JL on 4/25/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLbl: UILabel!
    
    @IBOutlet weak var hourLbl: UILabel!
    
    
    @IBOutlet weak var wageTxt: CurrencyTxtField!
    
    
    @IBOutlet weak var priceTxt: CurrencyTxtField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create the Calculate Button Programatically.
        let calBtn = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        calBtn.backgroundColor = #colorLiteral(red: 1, green: 0.7562473994, blue: 0.1115758255, alpha: 1)
        calBtn.setTitle("Calculate", for: .normal)
        calBtn.setTitleColor( #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        //Callback
        //Make the Calculate Button Select the Calculate function when touch up.
        calBtn.addTarget(self, action:  #selector(calculate), for: .touchUpInside)
        
        // Set the Button as the Accessory views on those two textField
        wageTxt.inputAccessoryView = calBtn
        priceTxt.inputAccessoryView = calBtn
        
        //
        resultLbl.isHidden = true
        hourLbl.isHidden = true
        
    }
    @objc func calculate(){
        //Perform calculations only if there is data in textFields
        if let wageTxt = wageTxt.text, let priceTxt = priceTxt.text{
            
            //Validation check agains  wrong data type ,
            //only Double allows, nothing else.
            if let wage = Double(wageTxt), let price = Double(priceTxt){
                //Get rid of the keyboard
                view.endEditing(true)
                resultLbl.isHidden = false
                resultLbl.isHidden = false
                
                //set the date inside the result's label
                resultLbl.text = "\(Wage.getHours(forWage: wage, andPrice: price))"
            }
            
        }
        
    }

   //Empty the textFiedls & hide the labels result & hours
    @IBAction func clearCalculatorPressed(_ sender: Any) {
        resultLbl.isHidden = true
        hourLbl.isHidden = true
        //Reset the wage & price textField to empty string
        wageTxt.text = ""
        priceTxt.text = ""
    }
    

}


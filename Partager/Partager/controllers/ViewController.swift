//
//  ViewController.swift
//  Partager
//
//  Created by JL on 5/25/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var resultText = ""
    
    //TextField one for number of guests, Implicit Optional type
    @IBOutlet weak var mangeursTxF: UITextField!
    //TextField two for total bill cost, Implicit Optional type
    @IBOutlet weak var totalCost: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
    }//end viewdidLoad
    
    //Dismiss the keyboard
    @objc func DismissKeyboard(){
        //Causes the view to resign from the status of first responder.
        view.endEditing(true)
    }
    //Verify there's values in textFields before trigger segue & display result
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //Unwrap Optional Binding
        if let mangerStr = mangeursTxF.text,
            let totalCostStr = totalCost.text,
            let manger = Double(mangerStr),
            let total = Double(totalCostStr) {
            
            if (mangerStr != "0") { //preventing division by zero
                
            //Format the results to 2 decimal points
            let formattedTotal = String(format: "%.2f", total/manger)
            let formattedCost = String(format: "%.2f", total)
            
            //Display the cost computation
             resultText = "La Facture:\n $\(formattedCost)\n Nomber De Mangeurs:\n \(Int(manger))\n Chacun paie:\n $\(formattedTotal)"
            return true
            }
        }
        //if no values return false
        return false
    }
    
    // Segue Btn to send outcome/open new VC, if above function is true
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            //Send/Transfer the resultText'value to other viewController
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.finalTxtResult = resultText
    }
    
    //Unwinding "X button " the segue once we in the 2nd screen
    @IBAction func dismissVC(segue: UIStoryboardSegue){}
    
    //Presenting the home view controller by code, not using segue
    @IBAction func home_btn(_ sender: Any) {
        if let homeVC = storyboard?.instantiateViewController(withIdentifier: "home")
        {
            present(homeVC, animated: true, completion: nil)
        }
    }
}//end Class

//
//  AddCarViewController.swift
//  HotCars
//
//  Created by JL on 6/7/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

//Inheritance , Conform to the Optional Delegates we need
class AddCarViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nametextField: UITextField!
    
    @IBOutlet weak var carImgView: UIImageView!
    
    @IBOutlet weak var selectCarButton: UIButton!
    
    @IBOutlet weak var characterCountLabel: UILabel!
    
    //User Input for TextField & ImageField validation
    var imagePicked = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hot Cars"
        
        //Call the Delegate for the textField itself
        nametextField.delegate = self
        nametextField.layer.cornerRadius = 10
        
        selectCarButton.layer.cornerRadius = 10
        
    }//end viewdidLoad
    
    
    //Now We can access all the methods & properties of TextField delegate

    //Behavior for the Return Button,
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nametextField.resignFirstResponder()
        return true
    }
    
    //Counting Number of Characters enter in Textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let length = textField.text?.count
        {
            characterCountLabel.text = "\(length + 1) Characters so far"
        }
        return true
    }


    //Select an image from Photo Library or Camera
    @IBAction func selectCar(_ sender: Any) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        
        present(photoPicker, animated: true, completion: nil)
    }
    
    //Let save the image that was picked/selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //Must cast "as?" an UIImage because it returns as "Any" & Optional
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            //If an Image was picked set the ImagePicked to true for field validation
            imagePicked = true
            carImgView.image = selectedImage
            
            //let display the selected image into the cells/list
            //Using insert() to add item in front of the  array
            imagesArray.insert(selectedImage, at: 0)
            
        }
        //dismiss the View Controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        //If no Image Picked Just return & don't save
        if !imagePicked {
            print("No image was selected")
            return
        }
        
        //Condition validation Check for the TextField
        if(nametextField.text?.isEmpty)!
        {
            print("Text input is missing")
            return
        }
        
        //let display the name entered  into the cells/list
        //name
        if let value = nametextField.text
        {
            //place new item in Array's Front
            namesArray.insert(value, at: 0)
            
            //Pop a View Controller & add item to top VC
            if let navController = navigationController
            {
                navController.popViewController(animated: true)
            }
        }
        
    }
    
}

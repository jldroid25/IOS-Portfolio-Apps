//
//  CollectionViewController.swift
//  Vacances
//
//  Created by JL on 6/29/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

var imagesArray = [
    UIImage(named:"1")!,UIImage(named:"2")!,UIImage(named:"3")!,
    UIImage(named:"4")!,UIImage(named:"5")!,UIImage(named:"6")!,
    UIImage(named:"7")!,UIImage(named:"8")!,UIImage(named:"9")!,
    UIImage(named:"10")!,UIImage(named:"11")!,UIImage(named:"12")!,
    UIImage(named:"13")!,UIImage(named:"14")!,UIImage(named:"15")!,
    UIImage(named:"16")!]

var namesArray = ["St Marten","Sechelle","Canary Island", "Mauracious",
                  "Hawai","Ils Vierge", "Bikini Island", "St Bart",
                  "Copa Cabana", "Jacmel", "fiji", "Toronto Island",
                  "Sydney","Penemunde","Haag Island","Modern Ils Vent"]


class HomeCollectionViewController: UICollectionViewController,
UIImagePickerControllerDelegate, UINavigationControllerDelegate,
UICollectionViewDelegateFlowLayout{

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //For the camera btn to open the camera
    @IBAction func openCamera(_ sender: Any) {
        
        //Verify if user's device has a sourceType to open Camera
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        
        //Let's allow Editing
        picker.allowsEditing = true
        //Mandatory delegate chaining
        picker.delegate = self
        //Now let's present it
        present(picker, animated: true)
        
        } else{
            //Let's display an alert dialog Box to user to inform them
            let alert = UIAlertController(title: "Camera is Unavailable", message: "Your Device doesn't have a camera", preferredStyle: .alert)
            //Now Let's add some action to the box
            let okAction = UIAlertAction(title: "Got It",
                                        style: .default, handler: nil)
            //Now add it
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        
    }
    
 
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        //return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // return the number of items
        return namesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "travelCell", for: indexPath) as! MyCollectionViewCell
        
        //Let access & retrieve the labels & Images
        cell.nameLabel.text = namesArray[indexPath.row]
        cell.pictureImgView.image = imagesArray[indexPath.row]
        
        return cell
    }
    
    //Let style the CellectionView cell, to have 2 items on display
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //resize it as per device screen size .
        //(We need to minus by 10 since we set up inset to 5 for left & right)
        //in 
        return CGSize(width: (collectionView.frame.size.width/2)-10,
                      height: (collectionView.frame.size.width/2))
    }
    
    //For the X BTN to close the view
    @IBAction func close(segue: UIStoryboardSegue){
        
    }
    
    //To navagate us to the FullImageVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let destinationVC = segue.destination as! FullImageViewController
        
        //Let's get the indexPath of the array
        if let indexPathArray = collectionView?.indexPathsForSelectedItems{
            
            let selectedIndexPath = indexPathArray[0]
            
            //Let's get the image
            let selectedImage = imagesArray[selectedIndexPath.row]
            
            destinationVC.fullImage = selectedImage
            
            
        }
        
    }

    
}

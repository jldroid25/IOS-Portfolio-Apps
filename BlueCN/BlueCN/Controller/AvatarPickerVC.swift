//
//  AvatarPickerVC.swift
//  BlueCN
//
//  Created by JL on 5/10/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit




class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    //Type of Avatar being Selected
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set our delegates & Datasource
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    //Conform to our protocols for the delegates
    
    //Display the cells collection
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //If we're able to dequeu cell  with this id, return cell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        //else return an empty
        return AvatarCell()
    }
    
    //How many section we have, only 1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //How many items/images are there to display
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return 28 //we have 28 images in asset folder
    }
    
    
    //IBActions
    
    @IBAction func backPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //Toggle back & forth for segmented control
    
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        } else {
            avatarType = .light
        }
        //Reload the data for cellForItemAt
        collectionView.reloadData()
    }
    
    //Provide better img sizes for type of Iphone dimension, 7, 8, SE ect
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Calculate the # of column within these screen sizesß
        var numOfColumns : CGFloat = 3
        //get the width of the screen size, if Iphone Se or bigger
        if UIScreen.main.bounds.width > 320 {
            numOfColumns = 4
        }
       //Caculate size of the spaces between cell
        let spaceBetweenCellls : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCellls) / numOfColumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    //allow user to Select an avatar
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }

}//end class

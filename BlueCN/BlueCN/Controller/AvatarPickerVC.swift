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
    }
    

}

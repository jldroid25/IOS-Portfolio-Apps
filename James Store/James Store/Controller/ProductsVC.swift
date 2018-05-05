//
//  ProductVC.swift
//  James Store
//
//  Created by JL on 4/28/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class ProductsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
   @IBOutlet weak var productsCollection: UICollectionView!
    
    private(set) public var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get appropriate the protocals & delegates on loading
        productsCollection.dataSource = self
        productsCollection.delegate = self

    }
    
    
    func initProducts(category: Category){
        //Get the title that was passed in from the  for the product category array
        products = DataService.instance.getProducts(forCategoryTitle: category.title)
    }
    
    //Protocals for our view cells
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return the number of items
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Recycle the views
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell {
            //Grab the approppriate row
            let product = products[indexPath.row]
            cell.updateViews(product: product)
            return cell
        }
        return ProductCell()
    }

}

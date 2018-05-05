//
//  ViewController.swift
//  James Store
//
//  Created by JL on 4/26/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

/*
 Feed the tableview with data source
 Protocal:
 Delegates.
 */

class CategoriesVC: UIViewController, UITableViewDataSource,
UITableViewDelegate {
    
    @IBOutlet weak var categoryTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Now set the data set & Delegates
        
        //Basically we're saying the Data set is this class
        categoryTable.dataSource = self
        categoryTable.delegate = self
    }
    
    //Our Protocals function
    
    //Number of rows to implement needs to be known in advanced
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return the total # of items in the array
        return DataService.instance.getCategories().count
    }
    
    //Let's create a cell at this particular path.
    //This where we feed tableView items # 1, 2 , 3, ect
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //dequeueReusableCell is the function to call to get
        //recycle cells/views. This save memories.
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryCell{
            
            //Grab the categories & specific index of that row
            let category = DataService.instance.getCategories()[indexPath.row]
            //update view
            cell.updateViews(category: category)
            return cell
        } else{
            return CategoryCell()
        }
    }
    
    //Passing the item selected to the new Product View controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Let's grab the appropriate category that was tapped
        let category = DataService.instance.getCategories()[indexPath.row]
        //Once we get that perticaular row, pass it to the segue
        //based on the segue identifier.
        performSegue(withIdentifier: "ProductsVC", sender: category)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Grab the appropriate destiantion & cast it as the gight view Controtter
        if let productsVC = segue.destination as? ProductsVC {
            //layer of protection, crash if no category data is available
            assert(sender as? Category != nil)
            productsVC.initProducts(category: sender as! Category)
        }
            
        }
}


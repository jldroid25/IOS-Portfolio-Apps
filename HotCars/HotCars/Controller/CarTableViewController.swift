//
//  CarTableViewController.swift
//  HotCars
//
//  Created by JL on 6/7/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

var namesArray = [String]()
var imagesArray = [UIImage]()

var name = ""

class CarTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return namesArray.count
    }

    
    //Display the Items to the cell using Tag numbers in Editor
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! CarTableViewCell
        
        //for the image
        
        cell.carImgview.image = imagesArray[indexPath.row]
        
        //For the Number Count Label
        cell.numberLabel.text = "\(indexPath.row + 1)"
        
        //For the Car Title
        cell.titleLabel.text = namesArray[indexPath.row]
        
        return cell
        
    }
    
    //Convenient method to load values on View controller on btn click
    @IBAction func load(_ sender: Any) {
        namesArray = ["Mercedes AMG", "Lotus", "Porsche", "Tesla"]
        imagesArray = [UIImage(named: "car1")!,UIImage(named: "car2")!, UIImage(named: "car3")!, UIImage(named: "car4")!]
        //reload/refresh the tableview
        tableView.reloadData()
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    //This allowa us to swipe to delete the item
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            //We must delete/remove the item(s) first
            namesArray.remove(at: indexPath.row)
            imagesArray.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        //Refresh the data to update the values
        tableView.reloadData()
    }
    
    /* Can use this function for when a row is selected
     to perform some action. i,e perform a segue to go
     to another (detail) VC for that perticular row.
    */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print("James, User had selected the row!")
        
        //Let's pass in the name of the item to new VC
        name = namesArray[indexPath.row]
        
        performSegue(withIdentifier: "detailVc", sender: self)
    }
    
    //Best way to send data from tablerow to new Vc is with prepareForSegue()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //first, get the indexpath where the row was selected
        if let myIndexPath = tableView.indexPathForSelectedRow
        {
            //2nd, let's get access to the desired data
            let name = namesArray[myIndexPath.row]
            let image = imagesArray[myIndexPath.row]
            
            //3rd, now send the data
            let destinationVC  = segue.destination as! AddCarViewController
           // destinationVC.
            //destinationVC.
            
        }
    }
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

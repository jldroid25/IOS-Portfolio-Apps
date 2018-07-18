//
//  ViewController.swift
//  Opus
//
//  Created by JL on 6/9/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

//Data Arrays
var taskArray = [String]()
var datesArray = [String]()

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var taskTableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //Always call reloadData to display the data
        //otherwise screen will be blank
        
        taskTableview.reloadData()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Display the Data coming from AddTaskVC on a UITableView
        taskTableview.dataSource = self

    }
    
    
    //configure cell items to be display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        //For the Title String, add 1 to first array index #
        cell.textLabel?.text = "\(indexPath.row + 1) \(taskArray[indexPath.row])"
        
        //For the Date formatted string
        cell.detailTextLabel?.text = datesArray[indexPath.row]
        
        return cell
    }
    
    //Todo
    
    //1 Use NSDefaultArray to save/persist data entered by user see other app
    
    //2 Delete a task with tableview Delete
    
    //Number of row(s) to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    
    //X Button to Close VC
    @IBAction func close(segue: UIStoryboardSegue)
    {
        
    }


}

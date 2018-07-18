//
//  AddTaskViewController.swift
//  Opus
//
//  Created by JL on 6/9/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController,
UIPickerViewDelegate, UIPickerViewDataSource {

    /* A Delegate is a way for an object to give us back some feedback/info
     on something/ task */
    
    
    //Items Outlets
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //DatePicker Formatter Object
    var dateFormatter = DateFormatter()
    
    
    //Array's of Tasks
    var tasks = ["Select Task", "Go to Gym", "Dentist Appointment", "Pay Bills",
                 "Study for finals", "Play Tennis", "Spring cleaning",
                 "Call Mom", "Grocery shopping", "Book Airline Ticket",
                 "Nordic Vacation", "Disconnect & Relax"]
    
    //To store a selected task
    var selectedTask = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Let's conform to the protocol dataSource, Needed for the Array's data
        pickerView.dataSource = self
        
        //Let's conform to the protocol pickerView
        pickerView.delegate = self
        
        
        
        //Disable the add Task Button
        addTaskButton.isEnabled = false
        addTaskButton.layer.cornerRadius = 10
        
        //Prevente past Date selection.
        datePicker.minimumDate = Date()
        
        //Let's format our dates Month-day-Year, Hour: Minutes
        //dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        //Format display Day, Month, ect..
        dateFormatter.dateFormat = "EE MMM-dd-yyyy HH:mm a"


    }//end viewDidLoad

    
  
    //Let's conform to the protocol pickerview for the 2 required functions
    
    //number of Item(s) to return
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return tasks.count
    }
    
    //Number of row(s) to return
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    //If a row was selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //Add Task Button Enabling State
        if row == 0 {
            addTaskButton.isEnabled = false
        } else {
            addTaskButton.isEnabled = true
            
            //Whatever user selected assign it to this variable
            selectedTask = tasks[row]
        }
     
        /*
        //Add item to front of Array
        taskArray.insert(tasks[row], at: 0)
        print(taskArray)
 */
        
        
    }
 
    
    //Display Row's title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tasks[row]
    }
    
    //Adding a Task
    @IBAction func addTask(_ sender: Any) {
        
        //get the date
        let date = datePicker.date
        // pass our date into a string
        let dateStr = dateFormatter.string(from: date)
        
        //Add the selected item (Task & Date) to front of Array
        taskArray.insert(selectedTask, at: 0)
        datesArray.insert(dateStr, at: 0)
        
        //Go to home VC with selected data when AddTask Button
            //is clicked & dismiss VC.
        dismiss(animated: true, completion: nil)
        
    }
    
}

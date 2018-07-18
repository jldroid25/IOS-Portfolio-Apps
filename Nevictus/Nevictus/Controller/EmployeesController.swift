//
//  EmployeesController.swift
//  Nevictus
//
//  Created by JL on 6/6/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit
import CoreData

//UILabel subclass to fix Sections Margin on TableView
class IndentedLabel : UILabel {
    override func drawText(in rect: CGRect) {
        
        let inserts = UIEdgeInsetsMake(0, 16, 0, 0)
        
        let customRect = UIEdgeInsetsInsetRect(rect, inserts)
        super.drawText(in: customRect)
    }
}

class EmployeesController: UITableViewController, CreateEmployeeControllerDelegate {
    
    //This is called when we dismissed employee creation
    func didAddEmployee(employee: Employee) {
        
        //------Adding animation when inserting employees--------//
        
        //What is the insertion index Path
        guard let section = employeeTypes.index(of: employee.type!) else { return }
        
        //What is my Row?
        let row = allEmployees[section].count
        
        let insertionIndexPath = IndexPath(row: row, section: section)
        
        allEmployees[section].append(employee)
        
        tableView.insertRows(at: [insertionIndexPath], with: .middle)
        
    }
    
    //Property to display company's name on employee's VC
    var company: CompanyEntity?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //set name in navbar
        navigationItem.title = company?.name
    }
    
    //To Render a Header for the section with label & colors
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        
        label.text = employeeTypes[section]
        label.backgroundColor = UIColor.lightBlue
        label.textColor = UIColor.bgDarkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    //Adjust the Header's height
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //2 Arrays to support the shor names & long names
    var shortNameEmployees = [Employee]()
    var longNameEmployees = [Employee]()
    var reallyLongNameEmployees = [Employee]()
    
    //Array of Arrays of all employees
    var allEmployees = [[Employee]]()
    
    //For our Types Employee filter
    var employeeTypes = [
    EmployeeType.Executives.rawValue,
    EmployeeType.Developers.rawValue,
    EmployeeType.Designers.rawValue,
    EmployeeType.Interns.rawValue
    ]
    
    //Fetch Request for employees with respective company
    private func fetchEmployees() {
        
        guard let companyEmployees = company?.employees?.allObjects as?
            [Employee] else {return}
        
        //Needed to add employees before we loop else app will crash
        allEmployees = []
        
        //Let's use the array & loop to filter instead
        employeeTypes.forEach {(EmployeeType) in
            
            //Construct all employees array
            allEmployees.append(
                companyEmployees.filter { $0.type == EmployeeType })
        }
        
    }//end Fetch Employees
    
    //Adding Sections for the UITableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    //Let's modify this function to display all employees's name length by section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let employee = allEmployees[indexPath.section][indexPath.row]
    
        cell.textLabel?.text = employee.fullName
        
        //to display the empoyee's name & BirthDay
        if let birthday = employee.employeeInformation?.birthday{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            
            cell.textLabel?.text = "\(employee.fullName ?? "")    \(dateFormatter.string(from: birthday))"
        }
        
        cell.backgroundColor = UIColor.tealColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        return cell
    }
    
    let cellId = "employeeCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEmployees()
        
        tableView.backgroundColor = UIColor.bgDarkBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        //For the Navbar add btn- in Helpers file
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
        
    }//end viewDidLoad
    
    @objc private func handleAdd() {
        let createEmployeeController = CreateEmployeeController()
        //Call the Delegate Pattern
        createEmployeeController.delegate = self
        createEmployeeController.company = company
        let navController = UINavigationController(rootViewController: createEmployeeController)
        present(navController, animated: true, completion: nil)
    }

}

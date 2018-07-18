//
//  CompaniesController+UITableView.swift
//  Nevictus
//
//  Created by JL on 5/24/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

extension CompaniesController {
    
    //Navigate to the Employees VC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //To display company's name whenever we're creating an Employee
        let company = companies[indexPath.row]
        //EmployeeController Object
        let employeesController = EmployeesController()
        employeesController.company = company
        navigationController?.pushViewController(employeesController, animated: true)
    }
    
    //Create the delete Action
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Delete action on the right swap
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (IndexPath , indexPath) in
            let company = self.companies[indexPath.row]
            
            //-1 to remove company from tableView
            
            //first remove the row from the tableView
            self.companies.remove(at: indexPath.row)//remove correct item
            
            //Now you can delete it.
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //-2, delete the company from Core Data/Datatbase using the context
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            
            //Now persist the deletion to make it permanent
            do {
                try context.save()
            } catch let saveErr {
                print("Failed to delete Company", saveErr)
            }
        }
        
        //Change delete action  color
        deleteAction.backgroundColor = UIColor.lightRed
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        
        //Change the Edit Action color
        editAction.backgroundColor = UIColor.bgDarkBlue
        
        return [deleteAction, editAction]
    } //end EditActionForRow
    
    //Edit the changes
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath){
        //Create a navController to take us to modal view
        let editCompanyController = CreateCompanyController()
        
        //Create a link between company view to edit View
        editCompanyController.delegate = self
        
        //Send the company to be edited to the new Edit view
        editCompanyController.company = companies[indexPath.row]
        let navController = CustomNavigationController(rootViewController: editCompanyController)
        
        //present us the modal screen.view
        present(navController, animated: true, completion: nil)
        
    } //end editHandlerFunction
    
    //Tableview for footer
    //If user tries to delete non existing data, inform the user there no data
    // to be deleted when all objects had already been deleted
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No companies available"
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    } //end ViewForFooter
    
    //Increase the footer's height
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        //If there is data in companies return height of 150 else return
        // 0 with "No companies availabel as above"
        return  companies.count == 0 ? 150 : 0
        
    } //end HeightForFooterInSection
    
    //TableView Row cells Header Section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view  = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    //TableView Row Header height
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    //Display the Row Cells & recycle views
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CompanyCell
        
        let company = companies[indexPath.row]
        cell.company = company
        return cell
    }
    
    //Increase the cells' height per row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //Display number rows as per existing ones in data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
} //end extention Controller

//
//  CompaniesAutoUpdateController.swift
//  Nevictus
//
//  Created by JL on 7/13/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit
import CoreData

class CompaniesAutoUpdateController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //Using NSFetchResultsController to provide us the Companies updates.
    
    //We need "lazy var" for the "frc.delegate = self" to work for the listening
    lazy var fetchResultsController: NSFetchedResultsController<CompanyEntity> = {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()
        
        //To sort our companies by name the CoreData attributes "name"
        request.sortDescriptors = [
        NSSortDescriptor(key: "name", ascending: true)
        ]
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "name", cacheName: nil)
       
        // Listening for Changes on coreData or context
        frc.delegate = self
        
        //Let's perform a fetch to get all companies
        do {
            try frc.performFetch()
        } catch let fetchErr{
            print("Unable to fetch sorted companies", fetchErr)
        }
        return frc
    }()
    
    //Now that we have the listening setup,
    //we can monitor what's happening with some delegate func.
    //these methods will be call whenever there is a C.R.U.D in CoreData
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    
    //For the Add Btn on this UIView
    @objc private func handleAdd(){
        
        
        //To add the company we must create it first
        
        //Create a context
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        //
        let company = CompanyEntity(context: context)
        company.name = "BMW"
        do {
            //Save it
            try context.save()
        } catch let saveErr {
            print("Unable to save the Created Company", saveErr)
        }
    }
    
    //For the Delete btn
    @objc private func handleDelete (){
        let request: NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()
        
        //Using a predicate to find the letter
        //request.predicate = NSPredicate(format: "name CONTAINS %@", "A")
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        do {
        
        let companiesWithC = try context.fetch(request)
            
            companiesWithC.forEach { (company) in
                context.delete(company)
            }
        } catch  let fetchErr{
            print(fetchErr)
        }
        
        do {
            try context.save()
            
        } catch let saveErr {
            print("Unable to Fetch Comapnies", saveErr)
        }
    }
    
    @objc private func handleRefresh(){
        
        Service.shared.downloadCompaniesFromServer()
        self.refreshControl = refreshControl
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Company Updates"
        
        tableView.backgroundColor = UIColor.bgDarkBlue
        
        //Register our cells that will be displayed
        tableView.register(CompanyCell.self, forCellReuseIdentifier: cellId)
        
        
        //To call the Json data from our Service Struct function
        //Service.shared.downloadCompaniesFromServer()
        
        //Using a refresh controll, for user to drag the view down to refresh data
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        refreshControl.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        self.refreshControl = refreshControl
        
        
        //Buttons to add & Delete companies in section on the UIView
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd)),
            
            UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(handleDelete))
        
        ]
        
    }//end viewDidLoad
    
   //Number of section to display
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultsController.sections?.count ?? 0
    }
    
    //Let Display the section within a section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        label.text = fetchResultsController.sectionIndexTitles[section]
        label.backgroundColor = UIColor.lightBlue
        return label
    }
    
    //Title to return from Fetch Result controller for The section Name
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return sectionName
    }
    
    //Give the Header section a height of 50
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //TableViews to display our data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchResultsController.sections![section].numberOfObjects
    }
    
    //Adjust the cell's row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //Cells for each individual rows to render
   let cellId = "cellId"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CompanyCell
        
        //Get the companies name to be rendered on the cells
        let company = fetchResultsController.object(at: indexPath)
        
        //To delete a specific section
        
        cell.company = company
        
        return cell
    }
    
    //-------To display the employees coming from JSON Api
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let employeesListController = EmployeesController()
        
        employeesListController.company = fetchResultsController.object(at: indexPath)
        
        navigationController?.pushViewController(employeesListController, animated: true)
    }
    
}// end class

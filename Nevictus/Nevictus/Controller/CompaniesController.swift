//
//  CompaniesController.swift
//  Nevictus
//
//  Created by JL on 5/8/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController {
    
    var companies = [CompanyEntity]() //empty Array
    
    @objc  private func doWork(){
        print("Trying to do work on background thread")
        
        //--The Recommended way to perform task on a background thread
    CoreDataManager.shared.persistentContainer.performBackgroundTask({ (backgroundContext) in
            
            /*
             Using an array of 1 million to loop through
             on the background thread so that main thread can be
             free for user to interact with
             */
        
        
            (0...5).forEach { (value) in
                print(value)
                let company = CompanyEntity(context: backgroundContext)
                company.name = String(value)
            }
            do {
                try backgroundContext.save()
                
                //Now let's update the main thread instantaneously with  the companies that were created on the background thread.
                
                DispatchQueue.main.async {
                    self.companies = CoreDataManager.shared.fetchCompanies()

                    self.tableView.reloadData()
                }
                
            } catch let err {
                print("Failed to save:", err)
            }
        })
    }// end Dowork
    
    
    //Attempt my Core Data fetch
   private  func fetchCompanies() {
    
} // end fetch companies
    
    
    //Let's do som tricky updates with core data
    
    @objc private func doUpdates(){
        print("Trying to updates Companies on a Background Context")
        
        CoreDataManager.shared.persistentContainer.performBackgroundTask { (backgroundContext) in
            
            //Let's first do a background fetch seperate from the main thread one
            let request: NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()
            
            do {
            let companies = try  backgroundContext.fetch(request)
                
                companies.forEach({ (company) in
                    print(company.name ?? "")
                    company.name = "C: \(company.name ?? " ")"
                })
                
                do {
                    try
                    backgroundContext.save()
                    
                    // Let's try to save the UI after a save
                    DispatchQueue.main.async {
                       
                       //Not recommended way
                    CoreDataManager.shared.persistentContainer.viewContext.reset()
                        
                        self.companies = CoreDataManager.shared.fetchCompanies()
                        
                        self.tableView.reloadData()
                    }
                    
                    
                } catch let saveErr {
                    print("Failed to save on background:", saveErr)
                }
                
            } catch let err {
                print("Failed to fetch companied on background: ", err)
            }
        }
        
    }// end updates
    
    //----------Better Way---------//
    //Using a Parent-child Nested Context to do work on background thread
    @objc private func doNestedUpdates(){
        print("Trying to perform nested updates now...")
        DispatchQueue.global(qos: .background).async {
            // We will try to perform our updates
            
            
            //--first Construct a custom M.O.C Manage Object Context
            let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            //Set the mainContext or thread to this parent context
            privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
            
            //Now, let execute updates on privateContext
            let request: NSFetchRequest<CompanyEntity> = CompanyEntity.fetchRequest()
            
            request.fetchLimit = 1
            
            do {
            let companies = try  privateContext.fetch(request)
                
                //Loop on companies Array to display the names
                companies.forEach({ (company) in
                    print(company.name ?? "")
                    company.name = "Mad Max: \(company.name ?? "")"
                })
                
                //call the save() whenever getting an entity's name
                do {
                    try privateContext.save()
                    
                    //After Save() had succeded go back on the main Queue
                    // to update the main thread with our updates
                    DispatchQueue.main.async {
                        
                        do {
                            //This line save the data to CoreData
                            let context = CoreDataManager.shared.persistentContainer.viewContext
                            //Verify if there is a change if yes, Save()
                            if context.hasChanges {
                                try context.save()
                            }
                            //To display data on View, but doesn't save it to CoreData
                            self.tableView.reloadData()
                        } catch let finalSaveErr {
                            print("Failed to save main context:", finalSaveErr)
                        }
                        
                    }// end DispactchQueue
                    
                } catch let saveErr {
                    print("Failed to save on private context:", saveErr)
                    
                }
                
            } catch let fetchErr {
                
                print("Failed to to fetch on privaate context", fetchErr)
            }
            
     }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.companies = CoreDataManager.shared.fetchCompanies()
        
        //Reset the table cells or Batch Delete all objects
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset)),
        
        // --- for Testing Background thread---//
          UIBarButtonItem(title: "Nested Updates", style: .plain, target: self, action: #selector(doNestedUpdates))]

        //Navbar Items
        navigationItem.title = "Companies"
        tableView.backgroundColor = UIColor.bgDarkBlue
        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()//blank UIView()
        
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "cellId")
        
        //setting for Right bar Btn from Helpers
        setupPlusButtonInNavBar(selector: #selector(handleAddCompany))
        
        
    }//end viewDidLoad
    
    //Reset all Core data object
    @objc private func handleReset() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        //Delete the data from the cell
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: CompanyEntity.fetchRequest())
        
        do {
            try   context.execute(batchDeleteRequest)
            
            //Upon Deletion from core data succeeded
            
            var indexPathsToRemove = [IndexPath]()
            
            for(index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            //Now Remove the data from CoreData itself
            companies.removeAll()
            
            //delete row with animation slide to the left
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
            
        } catch let delErr {
            print("Failed to delete objects from core Data:", delErr)
        }
    } //end handleReset()
    
    //Create new companies VC
    @objc func handleAddCompany()  {
        
        let createCompanyController =  CreateCompanyController()
        let navController = CustomNavigationController(rootViewController: createCompanyController )
        createCompanyController.delegate = self
        present(navController, animated: true, completion: nil)
    }
}

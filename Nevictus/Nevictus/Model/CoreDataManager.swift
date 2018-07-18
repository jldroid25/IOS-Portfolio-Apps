//
//  CoreDataManager.swift
//  Nevictus
//
//  Created by JL on 5/12/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    //Singleton to be accessible/share thoughout your code
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CompanyDataModels")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    //Fetch companies
    func fetchCompanies() -> [CompanyEntity] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CompanyEntity>(entityName: "CompanyEntity")
        
        do {
            let companies =  try context.fetch(fetchRequest)
            return companies
        } catch let fetchErr {
            print("Fetching Companies failed:", fetchErr)
            return []
        }
    }
    
    //Create Employees func to return a tuple of Employee & Error if fail
    func createEmployee(employeeName: String, employeeType: String, birthday: Date, company: CompanyEntity) -> (Employee?, Error?) {
        let context = persistentContainer.viewContext
        
        //Create a single employee
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        //To set an employee to his respective Company
        employee.company = company
        employee.type = employeeType
        
        
        
        employee.setValue(employeeName, forKey: "name")
        
        //Create/inserting EmployeeInfo into coreData similar for the name above
        let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation
        
        employeeInformation.taxId = "121"
        
        employeeInformation.birthday = birthday
        
        employee.employeeInformation = employeeInformation
        do {
            try context.save()
            //if Save Succeeds we'll get our employee
            return (employee, nil)
        } catch let err {
            print("Failed to create employee:", err)
            return (nil, err)
        }
    }
        
}

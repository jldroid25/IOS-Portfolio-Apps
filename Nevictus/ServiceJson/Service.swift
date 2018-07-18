//
//  Service.swift
//  Nevictus
//
//  Created by JL on 7/13/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import Foundation
import  CoreData

struct Service {
    
    //Turn this Service into a Singleton
    static let shared = Service()
    
    // the Json Data
    let urlString = "https://api.letsbuildthatapp.com/intermediate_training/companies"
    
    
    func downloadCompaniesFromServer(){
        print("Attempting to download companies...")
        
        guard let url = URL(string: urlString) else { return }
        //Let's do the download here to grab the json
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            print("Finished Downloaing the JSON")
            
            if let err = err {
                print("Failed to download companies:", err)
                return
            }
            
            //Print out what we are downloading
            guard let data = data else { return }
            
            
            //----The Parsing with Decodeable
            let jsonDecoder = JSONDecoder()
            
            do {
                let jsonCompanies = try jsonDecoder.decode([JSONCompany].self, from: data)
                
                //Context on the backGround Thread
                let privateContext = NSManagedObjectContext(concurrencyType:
                    .privateQueueConcurrencyType)
                
                //From previous Parent-child context
                privateContext.parent =
                    CoreDataManager.shared.persistentContainer.viewContext
                
                jsonCompanies.forEach({ (jsonCompany) in
                    print(jsonCompany.name)
                    
                    //To save our JSON Object into CoreData Object
                    let company = CompanyEntity(context: privateContext)
                    
                    //lets use the properties from company to our json ones
                    company.name = jsonCompany.name
                    
                    //convert the JSON date from string to Data object
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    
                    let foundedDate = dateFormatter.date(from: jsonCompany.founded)
                    
                    company.founded = foundedDate
                    
                    //loop to print the employees for companies that have ones
                    jsonCompany.employees?.forEach({ (jsonEmployee) in
                        
                        print("  \(jsonEmployee.name)")
                        
                        //Let's download the Json Employee object into CoreData
                        let employee = Employee(context: privateContext)
                        
                        employee.fullName = jsonEmployee.name
                        employee.type = jsonEmployee.type
                        
                        let employeeInformation = EmployeeInformation(context: privateContext)
                        
                        let birthdayDate = dateFormatter.date(from: jsonEmployee.birthday)
                        
                        employeeInformation.birthday = birthdayDate
                        
                        employee.employeeInformation = employeeInformation
                        
                        employee.company = company
                    })
                    
                    do {
                        try privateContext.save()
                        try privateContext.parent?.save()
                        
                    } catch let saveErr {
                        print("Unable to save Json object data into CoreData", saveErr)
                    }
                })
                
            } catch let jsonDecodeErr {
                print("Failed to decode ", jsonDecodeErr)
            }
            }.resume() //import must call for the downloading to start
    }
}// end Service struct


//Company Struct with the fields interested of getting from the Json api
//Important make it Decodable
struct JSONCompany: Decodable {
    
    let name: String
    let  founded: String
    var employees: [JSONEmployee]?
}

//Now let's defined the JSONEmployee object, make it also Decodable
struct JSONEmployee: Decodable {
    
    let name: String
    let type: String
    let birthday: String
    
}
















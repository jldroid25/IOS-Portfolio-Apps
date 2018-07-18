//
//  CompaniesController+CreateCompany.swift
//  Nevictus
//
//  Created by JL on 5/24/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

extension CompaniesController: CreateCompanyControllerDelegate {
    
    //Specify your extension methods here
    
    //Notify us when a company had finished being Edited
    func didEditCompany(company: CompanyEntity) {
        
        //Update my TableView
        let row =  companies.index(of: company)
        
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        //Reload the table view with the animation middle
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }
    
    func didAddCompany(company: CompanyEntity) {
        companies.append(company)
        //2 insert a new index path into tableView
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    

}

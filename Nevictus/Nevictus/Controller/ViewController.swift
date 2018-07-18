//
//  ViewController.swift
//  Nevictus
//
//  Created by JL on 5/8/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {
    
    //Arrays for companies
    let companies = [
        Company(name: "Apple", founded: Date()),
        Company(name: "Google", founded: Date()),
        Company(name: "Facebook", founded: Date()),
        Company(name: "Nevictus", founded: Date()),
        Company(name: "Statum Gaming", founded: Date()),
        Company(name: "Amazon", founded: Date()),
        Company(name: "Tesla", founded: Date()),
        Company(name: "Microsoft", founded: Date()),
        Company(name: "Ikea", founded: Date()),
        Company(name: "Restoration Hardware", founded: Date())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create Data objects
       
        
        //Add the add button on Navbar
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: #imageLiteral(resourceName: "add_box2") , style: .plain,  target: self,
                            action: #selector(handleAddCompany))
        
        //Define the tableview background Color
        tableView.backgroundColor = .bgDarkBlue
       
        //Remove the lines on the table row
        // tableView.separatorStyle = .none
        tableView.separatorColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        //Remove the lines on the footer view
        tableView.tableFooterView = UIView()
        
        // 3 - register a cell class for tableCells to work
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        //4 add the cell class in the App Delegate
        
        //Call our custom app style function
        setupNavigationStyle()
    }// end viewdidLoad
    
    
    @objc func handleAddCompany(){
        //to do
        print("Adding company")
    }
    
    //Create the Tableview Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    //Specify the header's height
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //1- Adding the table rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    //2- Add the needed cells for the table row above
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        //Add background Color
        cell.backgroundColor = .tealColor
        
        //Access Strings from  companies'arrays above
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.name
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        return cell
        
    }
    //
    
    //Nav Bar Style
    func  setupNavigationStyle()  {
        //Add Title
        navigationItem.title = "Companies"
        //Change VC backgc
        //view.backgroundColor = .white
        //Change Nav bar color to light red
        navigationController?.navigationBar.isTranslucent = false
       
        navigationController?.navigationBar.barTintColor = .lightRed
        //enable large navBar title
        navigationController?.navigationBar.prefersLargeTitles = true
        //navVar text color
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

}

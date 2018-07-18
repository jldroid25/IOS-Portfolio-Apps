//
//  ViewController.swift
//  Jindle
//
//  Created by JL on 5/6/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    /*
     Optional, ?, allows to work with properties with nil or no values.
     Your optional needs to be change from let to var since let is
     used for constant
     */
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call our navbar btn
        setupNavBarButtons()
    
        //CAll Setup function for app styles
        setupNavigationBarStyles()
        //Register our tableView cells
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        //Remove the horizontal lines on the footer
        tableView.tableFooterView = UIView()
        //Set the title
        navigationItem.title = "Jindle Books"
        //Set background color
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        //set the line separator color
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        //Prevent tableview footer from bounced
        tableView.alwaysBounceVertical = false
        //call our functions declared below
        fetchBooks()
        
    }// viewDidLoad
    
    
    //footer view
   override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue:
            40/255, alpha: 1);
    
    //Add a segment controller for the footer view
    let segmentedControl = UISegmentedControl(items: ["Cloud", "Device"])
    //add the color white
    segmentedControl.tintColor = .white
    //make "cloud" segment to be default one & automatically selectable
    segmentedControl.selectedSegmentIndex = 0
    
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    footerView.addSubview(segmentedControl)
    //Give them width & height & center anchor & constraint
    segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
    segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    segmentedControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
    segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
    
    //Add the gridButton
    let gridButton = UIButton(type: .system)
    gridButton.setImage(#imageLiteral(resourceName: "apps_white").withRenderingMode(.alwaysOriginal), for: .normal)
    gridButton.translatesAutoresizingMaskIntoConstraints = false
    footerView.addSubview(gridButton)
    //add constriants
    gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 8).isActive = true
    gridButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    gridButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
    
    //add the sort button on the right of the footer
    //Add the sortButton
    let sortButton = UIButton(type: .system)
    sortButton.setImage(#imageLiteral(resourceName: "swap_vert_white").withRenderingMode(.alwaysOriginal), for: .normal)
    sortButton.translatesAutoresizingMaskIntoConstraints = false
    footerView.addSubview(sortButton)
    
    //add constriants
    sortButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -8).isActive = true
    sortButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
   sortButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true

        return footerView
    }
    
    //Specify footer height to display it
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    //Add the navigation Buttons
    func setupNavBarButtons(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:
            #imageLiteral(resourceName: "burgerBtn").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuPress))
        
        //For right button amazon logo
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:
            #imageLiteral(resourceName: "amazLogo").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAmazonIconPress))
    }
    
    @objc func handleMenuPress(){
    print("Menu pressed")
    }
    
    @objc func handleAmazonIconPress(){
        print("Amazon Btn pressed")
    }
    
    //set up the navbar style
    func setupNavigationBarStyles() {
        //set the bgColor for navBar
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1);        navigationController?.navigationBar.isTranslucent = false
        
        //Set the NavBar Title color
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    /*
     Fetch list of books from our JSON data in the cloud
     */
    func fetchBooks(){
        //Reference to URL JSON Data
        //Safest way to unwrap the url
        if let url =  URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") {
            
        //Using a URLSession to get an external data
            //task to run on background thread
            URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
                
                //Always check for errors, ie wifi/cell network lost connection
                if let err = error{
                    print("Failed to fetch external JSON books: ", err)
                    //don't do anything else just return
                    return
                }
                
            //Safely unwrap the data bytes
                guard let data = data else { return }
                
                //Must throw a do-catch to handle error case
                do {
                    //Data Serialization
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    //Cast our JSON String dictionary array as any object
                    // [[String: Any]] is an Array of Dictionaries
                     guard let bookDictionaries = json as? [[String: Any]]
                        else{return}
                    
                    //empty array For the loop to store data into
                    self.books = []
                    //Loop though to display data
                    for bookDictionary in bookDictionaries{
                        
                    // A cleaner approach
                    let book = Book(dictionary: bookDictionary)
                    self.books?.append(book)
                    }
                    //Prevent Executing the call on the main thread
                    DispatchQueue.main.async {
                    //Display books to our book rows/cells
                    self.tableView.reloadData()
                    }
                    
                } catch let jsonError {
                print("Failed to parse JSON properly! ", jsonError)
            }
        }).resume() //Must always call .resume() in order get a response back
     }
}
    
    //Function to select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Verify which book that was clicked
        let selectedBook = self.books?[indexPath.row]
        //print(book?.title)
        
        //Present a view Controller layout when a row is clicked/selected
        let layout = UICollectionViewFlowLayout()
        let bookPagerController = BookPagerController(collectionViewLayout: layout )
        //Navigation Controller or NavBar for the BookPagerController
        let navController = UINavigationController(rootViewController: bookPagerController)
        //What to render
        bookPagerController.book = selectedBook
       
        present(navController, animated: true, completion: nil)
    }
    //Set the heights for our rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    //Set the cells for the tableView Rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //recycle a cell if possible or create new one for our  cellId
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        //Let's access the optional values in our book object
      let book = books?[indexPath.row]
        //Get the cell's properties
        cell.book = book
        return cell
    }
    
    //Set the tableView rows
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        //Get the lenght of the book Array with property .count
        // using if let as a safe way to unwrap the book optional.
        if let count = books?.count{
            return count
            
        } //if there is nothing or nil, don't crash,  return Zero
        return 0
    }
    
}// end class


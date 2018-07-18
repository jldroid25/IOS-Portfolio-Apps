//
//  CreateEmployeeController.swift
//  Nevictus
//
//  Created by JL on 6/6/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

//Establish our Protocol for creating employee
protocol CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
    
    var company: CompanyEntity?
    
    //Delegate to call didAddEmployee() Protocol
    var delegate: CreateEmployeeControllerDelegate?
    
    //closure Name Label
    let nameLabel:  UILabel = {
        let label = UILabel()
        label.text = "Name"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //textField closure
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //For the BirthDay Label
    let birthdayLabel:  UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //textField for Birthday
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "MM/dd/yyyy"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Employee"
        
        //From Helpers
        setupCancelButton()
      
        view.backgroundColor = UIColor.bgDarkBlue
        
        setupUI()
        
        //For the Save Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }// end ViewDidLoad
    
    private func setupUI() {
        _ = setupLightBlueBackgroundView(height: 150)

        view.addSubview(nameLabel)
        //Position the nameLabel
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        //Position the nameTextField
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        //Label For the Birthday
        view.addSubview(birthdayLabel)
        //Position the BirthDay Label
        birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        birthdayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        birthdayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        birthdayLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Position the TextField for the BirthDay
        view.addSubview(birthdayTextField)
        birthdayTextField.leftAnchor.constraint(equalTo: birthdayLabel.rightAnchor).isActive = true
        
        birthdayTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        birthdayTextField.bottomAnchor.constraint(equalTo: birthdayLabel.bottomAnchor).isActive = true
        
        birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.topAnchor).isActive = true
        
        //--------For the segmentedUI Employee types------------//
        view.addSubview(employeeTypeSegmentedControl)
        
        employeeTypeSegmentedControl.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 0).isActive = true
        
        employeeTypeSegmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        employeeTypeSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        employeeTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
    }
    
     @objc private func handleSave(){
        guard let employeeName = nameTextField.text else { return }
        guard let company =  self.company else {return}
        
        //Turn the birthdayTextFiel.text into a data object
        
        guard let birthdaytxt = birthdayTextField.text else { return}
        
        //Let's perform TextField Validatation
        if birthdaytxt.isEmpty {
            
            showError(title: "Empty Birthday", message: "You have not entered a birthday")
            
            //if birthday is empty, just return & don't continue creating the employee
            return
        }
        
        //Let's construct a data formatter to convert string entered into Data object
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        //now get the date object & make sure it's a valid date
        guard let birthdayDate = dateFormatter.date(from: birthdaytxt)
            else {
                showError(title: "Bad Date", message: "Birthday date entered is not valid.")
            return
        }
        
        //To Save data coming from UISegmented Controll
        guard  let employeeType = employeeTypeSegmentedControl.titleForSegment(at: employeeTypeSegmentedControl.selectedSegmentIndex) else {
            return }
        
        //Where we get the company from?
        let tuple = CoreDataManager.shared.createEmployee(employeeName: employeeName, employeeType: employeeType, birthday: birthdayDate, company: company)
        
        if let error = tuple.1 {
         //Present an Error Modal i.e with UIALertController to show Error msg.
            print(error)
        } else {
            //Creation Success
            dismiss(animated: true, completion: {
                // we'll call the delagate here
                self.delegate?.didAddEmployee(employee: tuple.0!)
                
            })
        }
   }
    
    //To display Error message for missing & invalid Date
    private func showError(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //Add the Ok action button to the alert
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
    
    //For the Three type of Employee's sections
    let employeeTypeSegmentedControl : UISegmentedControl = {
        //let types = ["Executives", "Developers", "Designers"]
        let types = [
        EmployeeType.Executives.rawValue,
        EmployeeType.Developers.rawValue,
        EmployeeType.Designers.rawValue,
        EmployeeType.Interns.rawValue
        ]
        
        let sc = UISegmentedControl(items: types)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.tintColor = UIColor.bgDarkBlue
        return sc
    }()
}

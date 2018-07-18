//
//  CreateCompanyController.swift
//  Nevictus
//
//  Created by JL on 5/8/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit
import CoreData

// Custom Delegate

protocol CreateCompanyControllerDelegate {
    func didAddCompany(company: CompanyEntity)
    func didEditCompany(company: CompanyEntity)
}

class CreateCompanyController: UIViewController,
UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Create company for the edit company view
    var company: CompanyEntity? {
        
        //Pass over the name & founded date of the specific company
        //trying to edit to the textField
        didSet {
            nameTextField.text = company?.name
            
            //
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
                //call secular Image style
                setupcircularImageStyle()
            
            }
            guard let founded = company?.founded else { return }
            datePicker.date = founded
        }
    }
    
    //for the circular image style
    private func setupcircularImageStyle() {
        //make image circular/rounded
        companyImageView.layer.cornerRadius =
            companyImageView.frame.width / 2
        companyImageView.clipsToBounds = true
        //add a border & color
        companyImageView.layer.borderColor = UIColor.bgDarkBlue.cgColor
        companyImageView.layer.borderWidth = 2

    }
    
    //using the delegate
    var delegate: CreateCompanyControllerDelegate?
    
    var companiesController: CompaniesController?
    
    //To select pictures, using Lazy var to prevent nil value
    lazy var  companyImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "companyImg2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        //Change the image aspect ratio
        imageView.contentMode = .scaleAspectFill
        
        //You must allow user to select image so we can make it interactive
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return imageView
    }()
    
    @objc private func handleSelectPhoto(){
        
        //open the Image Picker
        let imagePickerController = UIImagePickerController()
        //Now  select the  image
        imagePickerController.delegate = self
        //Allow editing on the image
        imagePickerController.allowsEditing = true
        //show us the image
        present(imagePickerController, animated: true, completion: nil)
        
    }
    //Close the imagePicker Modal
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    //Will launch whenever user select a photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //Access the image from the dictionary.
        //Also  let us to edit the picked image
        if let editedImage = info[UIImagePickerControllerEditedImage]
            as? UIImage {
            companyImageView.image = editedImage
        }
            //or let us edit the original image
        else if let originalImage =
            info[UIImagePickerControllerOriginalImage] as? UIImage {
            companyImageView.image = originalImage
        }
        
        //Circular Image style
        setupcircularImageStyle()
        
        //dismiss the ImagePicker
        dismiss(animated: true, completion: nil)
    }
    
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
    
    //Create a date picker property
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        //Only display Date, no time
        dp.datePickerMode = .date
        //enable autoLayout for us
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    //Edit company view title
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //ternary operator check
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.bgDarkBlue
        
        //Cancel Btn
        setupCancelButton()
        
        //Save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        //Call SetUpUI
        setUpUI()
    }
    
    
    //Save Companies
    @objc private func handleSave(){
        if company == nil {
            createCompany()
        } else {
            saveCompanyChanges()
        }
        
    } // end Handle Save
    
    
    //Save the company Edit
    private func saveCompanyChanges() {
        
        //Always call the context Object
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        //Persiting the changes to the new name & date
        company?.name = nameTextField.text
        company?.founded = datePicker.date
        
        //To save/display the image as well in the company's list cells
        if let companyImage = companyImageView.image {
            let imageData = UIImageJPEGRepresentation(companyImage, 0.8)
            company?.imageData = imageData
        }
        
        
        do {
            try context.save() //Make it permanent with coreData
            //Save succeeded
            dismiss(animated: true, completion: {
                self.delegate?.didEditCompany(company: self.company!)
            })
            
            
        } catch let saveError{
            print("Failed to save company chnages", saveError)
        }
    }
    
    
    private func createCompany() {
        //-1 initialization of our Core Data Stack
        //Create the context from te persistent container
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "CompanyEntity", into: context)
        
        //Get the attribute called "name", founded, imageData that was add in CompanyEntity
        //From the textfield nameTxtField.text
        
        company.setValue(nameTextField.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        
        if let companyImage = companyImageView.image {
        let imageData = UIImageJPEGRepresentation(companyImage, 0.8)
        company.setValue(imageData, forKey: "imageData")
        }
        
        //-2 Perform the save
        
        do {
            try context.save()
            
            //on success dismiss, the view, return to tableCell
            dismiss(animated: true, completion: {
                self.delegate?.didAddCompany(company: company as! CompanyEntity)
                
            })
            
        } catch let saveErr {
            print("Failed to save company!", saveErr)
        }
    }
    
    private func setUpUI(){
        
      let lightBlueBackgroundView = setupLightBlueBackgroundView(height: 350)
        
        //Constaint for placing the SelectCompany Image
        view.addSubview(companyImageView)
        companyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        companyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(nameLabel)
        //Position the nameLabel
        nameLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor).isActive = true
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
        
 
        
        //Setup the DatePicker
        view.addSubview(datePicker)
        //place it into the view
        datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: lightBlueBackgroundView.bottomAnchor).isActive = true
        
    } //end setupUI
}

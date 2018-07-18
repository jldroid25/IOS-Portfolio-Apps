//
//  CompanyCell.swift
//  Nevictus
//
//  Created by JL on 5/24/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    //Our coreData Company entity
    var company: CompanyEntity? {
        didSet {
            //display the company'names on the cell's row
            nameFoundedDateLabel.text = company?.name
            
            
             //Display the image on the cell
             //cell.imageView?.image = #imageLiteral(resourceName: "companyImg2")
             
             if let imageData = company?.imageData {
             companyImageView.image = UIImage(data: imageData)
             }
            
            //Display the founded date next to company's name
            if let name = company?.name, let founded = company?.founded{
                
                //Let's format the date, MMM Day, yyyy
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                let foundedDateString = dateFormatter.string(from: founded)
                //Print name & new formatted date
                let dateString = "\(name) - Founded: \(foundedDateString)"
                
                nameFoundedDateLabel.text = dateString
                
            } else {
                nameFoundedDateLabel.text = company?.name
                
                //For the Number of employees changes in coreData
                nameFoundedDateLabel.text = "\(company?.name ?? "")\(company?.numEmployees ?? "")"
            }
        }
    }
    
    //Create a custom ImageView
    let companyImageView: UIImageView = {
        //Don't reuse the name "imageView " again
        let imageView = UIImageView(image: #imageLiteral(resourceName: "companyImg2"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.bgDarkBlue.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    //Create a custom Label
    let nameFoundedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "COMPANY NAME"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //cell bgcolor
        backgroundColor = UIColor.tealColor
        
        //Let's layout the custom imageView in our cells
        addSubview(companyImageView)
        companyImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        companyImageView.leftAnchor.constraint(equalTo: leftAnchor,
                                               constant: 16).isActive = true
        companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        //Adding our  Name, Founded, Date Label
        addSubview(nameFoundedDateLabel)
        nameFoundedDateLabel.leftAnchor.constraint(equalTo: companyImageView.rightAnchor, constant: 8).isActive = true
        nameFoundedDateLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameFoundedDateLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        nameFoundedDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}















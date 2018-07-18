//
//  BookCell.swift
//  Jindle
//
//  Created by JL on 5/7/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit
/*
 class to custom design our row cells as we desire
 instead of using default design provided 
 */
class BookCell: UITableViewCell {
    
    //call didSet{} everytime you want to set properties
    var book: Book?{
        didSet {
            titleLabel.text = book?.title
            authorLabel.text = book?.author
            
            guard  let coverImageUrl = book?.coverImageUrl else {return}
            guard let url =  URL(string: coverImageUrl) else {return}
            /*
             If images are loading slow & get other image
              set the image to nil/null
             to allow the image to reload & cover that slot.
             */
            coverImageView.image = nil
            
            URLSession.shared.dataTask(with: url) {(data, response, error)
                in
                //safety check , ie no network/wify connection
                if let err = error {
                    print("Failed to retrieve our book cover image: ", err)
                    return
                }
                
                guard let imageData = data else {return}
                let image = UIImage(data: imageData)
                
                //Load the image inside the main thread
                DispatchQueue.main.async {
                self.coverImageView.image = image
                }
            }.resume() //always call it
        }
    }
    
      private let coverImageView : UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }() //the () is there to execute the code block giving us the imageView back
    
    //Create the labels for book title
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
       // label.text = "This is the text for the title of our book inside of our cell"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }() //execute block & give back the label
    
    //Author Label
   private let authorLabel: UILabel = {
        let label = UILabel()
    label.textColor = .lightGray
        //label.text = "This is the author for the book that we have in this  row"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Override the initializer that gets call
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
      backgroundColor = .clear
        
        //add the subview for ImageView to our cells
        addSubview(coverImageView)
        //Constraint for Cover View Image
        //Add anchor & constraint pin  8 pixes padding from the left
        coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor,
                                             constant: 8).isActive = true
        //Give it 8 pixels of padding to the top
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: 8).isActive = true
        //Give it bottom padding, Must use a negative number for bottom
        coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                               constant: -8).isActive = true
        //Set the width constraint
        coverImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        //Add Title Label constraint
        addSubview(titleLabel)
        //Constraint or pin 8 pixels to the right of coverImageView
        titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        //Width of the constrait, negative constant value for right anchor
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 8).isActive = true
        //How tall it should be
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        
        //Add the authorLabel constraints
        addSubview(authorLabel)
        //Place at the bottom of titleLabel 8 pixels constraint
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        //How wide to be, left Anchor
        authorLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        // How wide constraint needs to be for Right Anchor
        authorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        // how tall constraint needs to be
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

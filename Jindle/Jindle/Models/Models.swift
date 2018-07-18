//
//  Models.swift
//  Jindle
//
//  Created by JL on 5/6/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import UIKit

//Define our custom classes

//Book class
class Book {
    //Define Properties
    let title: String
    let author: String
    
    //To refer to the array Object type of Page, syntax use a:[X]
    let pages: [Page]
    
    let coverImageUrl: String
    
    //For the JSON Data Arrray
    init(dictionary: [String: Any]) {
        //cast as a String, unwrap, else return an empty string
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        self.coverImageUrl = dictionary["coverImageUrl"] as? String ?? ""
        
        //Declare an empty page array for the pages
        var bookPages = [Page]()
        
        //Accessing the  pages
        if let  pagesDictionaries = dictionary["pages"] as? [[String: Any]]{
            for pageDictionary in pagesDictionaries{
                
                //Construct our page Object
                if let pageText = pageDictionary["text"] as? String {
                    
                    let page = Page(number: 1, text: pageText)
                    
                    bookPages.append(page)
                }
            }
        }
        pages = bookPages
    }
}

//Page Class

class Page {
    let number: Int
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}

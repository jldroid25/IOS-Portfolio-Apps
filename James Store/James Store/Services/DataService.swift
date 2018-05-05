//
//  DataService.swift
//  James Store
//
//  Created by JL on 4/27/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import Foundation

/*
 A service does task for us.
 In this app we need a service to grab the data over
 & over .
 */

class DataService  {
    /*-This is Singleton Design pattern--
     
    "static" makes this constant non duplicable
    It cannot exist anywhere else . There can only
    be a single copy in memory.
     Note: use singleton carefully because to many will
     drain memory on the app.
    */
    static let instance = DataService()
    
    
    //Data Array of type categories
    private let categories = [
    Category(title: "SHIRTS", imageName: "shirts.png") ,
    Category(title: "HOODIES", imageName: "hoodies.png"),
    Category(title: "HATS", imageName: "hats.png"),
    Category(title: "DIGITAL", imageName: "digital.png")
    ]
    
    //Create some data for our produtcs Items based on available image Asset
    
    private let hats = [
    Product(title: "James Store Logo Graphic Beanie", price: "$12", imageName: "hat01.png"),
    Product(title: "James Store Black Hat", price: "$21", imageName: "hat02.png"),
    Product(title: "James Store White Hat", price: "$22", imageName: "hat03.png"),
    Product(title: "James Store Logo Snapback", price: "$20", imageName: "hat04.png")]
    
    private let hoodies = [
    Product(title: "New Englad Black Hoodie", price: "$65", imageName: "hoodie01.png"),
    Product(title: "New England Red Hoodie", price: "$70", imageName: "hoodie02.png"),
    Product(title: "New England Charcoal", price: "$65", imageName: "hoodie03.png"),
    Product(title: "NEw England Dark Chowder", price: "$55", imageName: "hoodie04.png")
        ]
    
    private let shirts = [
    Product(title: "Uptown Shirt Black", price: "$20", imageName: "shirt01.png"),
    Product(title: "Mafia Light gray T", price: "$22", imageName: "shirt02.png"),
    Product(title: "Dangerous Red T-shirt", price: "$17", imageName: "shirt03.png"),
    Product(title: "James Store Dark-Gray", price: "$21", imageName: "shirt04.png"),
    Product(title: "Black Forest T-shirt", price: "$20", imageName: "shirt05.png")
    ]
    
    //Digital with empty array to prevent crash
    private let digitalGoods = [Product]()
/*
   private let other = [
    Product(title: <#T##String#>, price: <#T##String#>, imageName: <#T##String#>),
    Product(title: <#T##String#>, price: <#T##String#>, imageName: <#T##String#>),
    Product(title: <#T##String#>, price: <#T##String#>, imageName: <#T##String#>),
    Product(title: <#T##String#>, price: <#T##String#>, imageName: <#T##String#>)
    ]
 */
    
    
    
    //whoever call this function
    func getCategories() -> [Category]{
        //return categories
        return categories
        
    }
    
    //Let s get the items once User click a specific ite,
    //Based on Item titles.
    //This technique is similar to a server call
    
    func getProducts(forCategoryTitle title:String) -> [Product] {
        switch title {
        case "SHIRTS":
           return getShirts()
        case "HATS":
            return getHats()
        case "HOODIES":
            return getHoodies()
        case "DIGITAL":
            return getDigitalGoods()
        default:
            return getShirts()
        }
    }
    
    func getHats() -> [Product] {
        return hats
    }
    func getShirts() -> [Product] {
        return shirts
    }
    func getHoodies() -> [Product] {
        return hoodies
    }
    func getDigitalGoods() -> [Product] {
        return digitalGoods
    }

}

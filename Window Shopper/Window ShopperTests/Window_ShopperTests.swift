//
//  Window_ShopperTests.swift
//  Window ShopperTests
//
//  Created by JL on 4/26/18.
//  Copyright © 2018 jldroidSwift25. All rights reserved.
//

import XCTest

class Window_ShopperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    
    //Let's write Unit Testing to verify if our calculate method works as
    //espected/ Produce   the Desired result.
    //Don't need Unit test for UI.
    //But Write them Business Logic of your app
    //--------------Always Test first before running the codes--------
    //Never ship code with red-x or failing Unit-Test
    func testGetHours(){
        XCTAssert(Wage.getHours(forWage: 25, andPrice: 100) == 4)
        XCTAssert(Wage.getHours(forWage: 15.50, andPrice: 250.53) == 17)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

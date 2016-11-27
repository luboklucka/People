//
//  PeopleTests.swift
//  PeopleTests
//
//  Created by Lubomir Klucka on 25/11/2016.
//  Copyright © 2016 luboklucka. All rights reserved.
//

import XCTest
@testable import People

class PeopleTests: XCTestCase {
    var viewController: PeopleViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let tabBarController = storyboard.instantiateInitialViewController() as! UITabBarController
        let navigationController = tabBarController.viewControllers?[0] as! UINavigationController
        viewController = navigationController.topViewController as! PeopleViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStringSorting() {
        let address = Address(street: "", suite: "", city: "", zipCode: "", geoLocation: GeoLocation(latitude: "", longitude: ""))
        let company = Company(name: "", catchPhrase: "", bs: "")
        let firstUser = User(id: 1, name: "Yvonne", username: "", email: "", address: address, phone: "", website: "", company: company)
        let secondUser = User(id: 2, name: "George", username: "Clooney", email: "", address: address, phone: "", website: "", company: company)
        
        let arrayToSort = [firstUser, secondUser]
        let finalArray = [secondUser, firstUser]
        
        let sortedArray = viewController.sortUserListAlphabetically(arrayToSort)
        XCTAssert(sortedArray[0].name == finalArray[0].name)
        XCTAssert(sortedArray[1].name == finalArray[1].name)
    }
}

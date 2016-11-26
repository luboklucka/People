//
//  PeopleViewController.swift
//  People
//
//  Created by Lubomir Klucka on 25/11/2016.
//  Copyright © 2016 luboklucka. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PeopleViewController: UIViewController {
    // MARK: Constants and variables
    var userList: [User] = []
    
    // MARK: IBOutlets
    
    // MARK: IBActions
    
    // MARK: UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadUsersTest()
        loadUsers()
    }

    // MARK: Custom functions
    func loadUsers() {
        RestApiManager.sharedInstance.getAllUsers { (results) in
            for (key,userJson):(String, JSON) in results {
                print("----------------------------------")
                print(key)
                print(userJson)
                print("----------------------------------")
                
                let companySubJson = userJson["company"]
                let addressSubJson = userJson["address"]
                let geoSubJson = addressSubJson["geo"]
                
                let geoLocation = GeoLocation(latitude:  geoSubJson["lat"].stringValue,
                                              longitude: geoSubJson["lng"].stringValue)
                
                let address = Address(street:       addressSubJson["street"].stringValue,
                                      suite:        addressSubJson["suite"].stringValue,
                                      city:         addressSubJson["city"].stringValue,
                                      zipCode:      addressSubJson["zipcode"].stringValue,
                                      geoLocation:  geoLocation)
                
                let company = Company(name:         companySubJson["name"].stringValue,
                                      catchPhrase:  companySubJson["catchPhrase"].stringValue,
                                      bs:           companySubJson["bs"].stringValue)
                
                let user = User(id:        userJson["id"].intValue,
                                 name:      userJson["name"].stringValue,
                                 username:  userJson["nae"].stringValue,
                                 email:     userJson["email"].stringValue,
                                 address:   address,
                                 phone:     userJson["phone"].stringValue,
                                 website:   userJson["website"].stringValue,
                                 company:   company)
                
                self.userList.append(user)
            }
            
        }
    }
}

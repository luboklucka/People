//
//  RestApiManager.swift
//  People
//
//  Created by Lubomir Klucka on 25/11/2016.
//  Copyright © 2016 luboklucka. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol RestApiProtocol {
    func getAllUsers(onCompletion: @escaping ([User], Error?) -> Void)
}

class RestApiManager: RestApiProtocol {
//    static let sharedInstance = RestApiManager()
    
//    init() {
//        
//    }
    
    let baseURL     = "http://jsonplaceholder.typicode.com/"
    let postsURL    = "posts/"
    let commentsURL = "comments/"
    let albumsURL   = "albums/"
    let photosURL   = "photos/"
    let todosURL    = "todos/"
    let usersURL    = "users/"
    
    func getAllUsers(onCompletion: @escaping ([User], Error?) -> Void) {
        let route = baseURL + usersURL
        
        Alamofire.request(route)
            .responseJSON { (response) in
                var userList = [User]()
                
                switch response.result {
                case .success:
                    if response.result.value != nil {
                        let results = JSON(response.result.value!)
                        for (_,userJson):(String, JSON) in results {
                            print(userJson)
                            print("----------------------------------")
                            
                            let user = self.getParsedUserResults(userJson)
                            userList.append(user)
                        }
                    }
                    onCompletion(userList, nil)
                case .failure(let error):
                    onCompletion(userList, error as Error?)
                }
        }
    }
    
    private func getParsedUserResults(_ userJson: JSON) -> User {
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
        
        return User(id:        userJson["id"].intValue,
                    name:      userJson["name"].stringValue,
                    username:  userJson["username"].stringValue,
                    email:     userJson["email"].stringValue,
                    address:   address,
                    phone:     userJson["phone"].stringValue,
                    website:   userJson["website"].stringValue,
                    company:   company)
    }
}

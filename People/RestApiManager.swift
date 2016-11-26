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

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager {
    static let sharedInstance = RestApiManager()
    
    let baseURL     = "http://jsonplaceholder.typicode.com/"
    let postsURL    = "posts/"
    let commentsURL = "comments/"
    let albumsURL   = "albums/"
    let photosURL   = "photos/"
    let todosURL    = "todos/"
    let usersURL    = "users/"
    
    func getAllUsers(onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL + usersURL
        makeHTTPGetRequest(path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: @escaping ServiceResponse) {
//        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
//        let session = URLSession.shared
//        
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error -> Void in
//            if data != nil {
//                let json: JSON = JSON(data: data!)
//                onCompletion(json, error as NSError?)
//            } else {
////                onCompletion(error as NSError?)
//            }
//        })
//        task.resume()
        
        
        // TODO: Where to parse the object? - ViewController or RestApiManager or dedicated parser?
        
        Alamofire.request(path)
            .responseJSON { (response) in
                if response.result.value != nil {
                    
                    onCompletion(JSON(response.result.value!), response.result.error as NSError?)
                
//                    guard let json = response.result.value as? [String:AnyObject] else { return }
//                    print(json)
//                    onCompletion(response.result.value as! JSON, response.result.error as NSError?)
//                    if let JSON = response.result.value as? [String:AnyObject], let items = JSON["items"] as? [[String:AnyObject]] {
//                        if items.count > 0 {
//                        }
                    }
//                }
            
        }
    }
}

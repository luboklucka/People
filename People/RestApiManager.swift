//
//  RestApiManager.swift
//  People
//
//  Created by Lubomir Klucka on 25/11/2016.
//  Copyright © 2016 luboklucka. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager {
    static let sharedInstance = RestApiManager()
    
    let baseURL     = "http://jsonplaceholder.typicode.com/"
    let postsURL    = "/posts"
    let commentsURL = "/comments"
    let albumsURL   = "/albums"
    let photosURL   = "/photos"
    let todosURL    = "/todos"
    let usersURL    = "/users"
    
    func getAllUsers(onCompletion: (JSON) -> Void) {
        let route = baseURL + usersURL
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error -> Void in
            let json: JSON = JSON(data: data)
            onCompletion(json, error)
        })
        task.resume()
    }
}

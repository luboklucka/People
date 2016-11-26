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

class PeopleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Constants and variables
    let userCellIdentifier = "userCell"
    var userList: [User] = []
    
    // MARK: -
    // MARK: IBOutlets
    @IBOutlet weak var userTableView: UITableView!
    
    // MARK: -
    // MARK: IBActions
    
    // MARK: -
    // MARK: UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers()
    }

    // MARK: -
    // MARK: Custom functions
    func loadUsers() {
        RestApiManager.sharedInstance.getAllUsers { (results) in
            self.userList = results
            self.userTableView.reloadData()
        }
    }
    
    // MARK: -
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: userCellIdentifier, for: indexPath)
        userCell.textLabel?.text = userList[indexPath.row].name
        
        return userCell
    }
    
    
}

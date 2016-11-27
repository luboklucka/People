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
    // MARK: - Constants and variables
    let userCellIdentifier = "userCell"
    let userDetailSegueIdentifier = "userDetailSegue"
    var userList: [User] = []
    var refreshControl: UIRefreshControl!
    
    // MARK: - IBOutlets
    @IBOutlet weak var userTableView: UITableView!
    
    // MARK: - IBActions
    
    // MARK: - UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRefreshControlToTableView()
        loadUsers()
    }

    // MARK: - Custom functions
    func loadUsers() {
        RestApiManager.sharedInstance.getAllUsers { (results) in
            self.userList = self.sortUserListAlphabetically(results)
            self.refreshControl.endRefreshing()
            self.userTableView.reloadData()
        }
    }
    
    func sortUserListAlphabetically(_ userList: [User]) -> [User] {
         return userList.sorted(by: { (user1, user2) -> Bool in
            // Remove title "Mrs." from sorting comparison
            let user1substring = (user1 as User).name.replacingOccurrences(of: "Mrs. ", with: "")
            
            if user1substring < (user2 as User).name {
                return true
            }
            return false
        })
    }
    
    func addRefreshControlToTableView() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Loading data")
        refreshControl.addTarget(self, action: #selector(PeopleViewController.reloadTableViewData), for: UIControlEvents.valueChanged)
        userTableView.addSubview(refreshControl)
    }
    
    func reloadTableViewData() {
        loadUsers()
    }
    
    // MARK: - UITableViewDataSource
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == userDetailSegueIdentifier,
            let destination = segue.destination as? UserDetailViewController,
            let userIndex = userTableView.indexPathForSelectedRow?.row
        {
            destination.user = userList[userIndex]
        }
    }
}

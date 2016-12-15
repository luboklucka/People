//
//  PeopleViewController.swift
//  People
//
//  Created by Lubomir Klucka on 25/11/2016.
//  Copyright © 2016 luboklucka. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Constants and variables
    let peopleViewControllerRefreshButtonKey = "PeopleViewControllerRefreshButton"
    let peopleViewControllerTitleKey = "PeopleViewControllerTitle"
    let peopleViewControllerNoDataKey = "PeopleViewControllerNoData"
    let errorViewAnimationDuration = 0.5
    let userCellIdentifier = "userCell"
    let userDetailSegueIdentifier = "userDetailSegue"
    var userList: [User] = []
    var refreshControl: UIRefreshControl!
    var restApiDelegate: RestApiProtocol!
    
    // MARK: - IBOutlets
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func refreshButtonPressed(_ sender: Any) {
        loadUsers()
    }
    
    // MARK: - Initializer
    convenience init(delegate: RestApiProtocol) {
        self.init()
        restApiDelegate = delegate
        restApiDelegate.getAllUsers { (results, error) in
            print("got all users")
            print("oh yah")
        }
//        super.init(nibName: nil, bundle: nil)
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // MARK: - UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeRefreshButton()
        initializeNavigationBar()
        initializeTableView()
        initializeErrorViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadUsers()
    }

    // MARK: - Custom functions
    func loadUsers() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        restApiDelegate.getAllUsers { (results, error) in
            if error == nil {
                if results.isEmpty {
                    self.errorLabel.text = String.localizedStringWithKey(self.peopleViewControllerNoDataKey)
                    self.showErrorView()
                } else {
                    self.userList = self.sortUserListAlphabetically(results)
                    self.refreshControl.endRefreshing()
                    self.userTableView.reloadData()
                    self.hideErrorView()
                }
            } else {
                self.errorLabel.text = error?.localizedDescription
                self.showErrorView()
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
//        RestApiManager.sharedInstance.getAllUsers { (results, error) in
//            if error == nil {
//                if results.isEmpty {
//                    self.errorLabel.text = String.localizedStringWithKey(self.peopleViewControllerNoDataKey)
//                    self.showErrorView()
//                } else {
//                    self.userList = self.sortUserListAlphabetically(results)
//                    self.refreshControl.endRefreshing()
//                    self.userTableView.reloadData()
//                    self.hideErrorView()
//                }
//            } else {
//                self.errorLabel.text = error?.localizedDescription
//                self.showErrorView()
//            }
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//        }
    }
    
    func sortUserListAlphabetically(_ userList: [User]) -> [User] {
         return userList.sorted(by: { (user1, user2) -> Bool in
            // Remove title "Mrs." from sorting comparison
            let user1Substring = (user1 as User).name.replacingOccurrences(of: "Mrs. ", with: "")
            
            if user1Substring < (user2 as User).name {
                return true
            }
            return false
        })
    }
    
    func addRefreshControlToTableView() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PeopleViewController.reloadTableViewData), for: UIControlEvents.valueChanged)
        userTableView.addSubview(refreshControl)
    }
    
    func reloadTableViewData() {
        loadUsers()
    }
    
    func hideErrorView() {
        UIView.animate(withDuration: errorViewAnimationDuration) {
            self.errorView.alpha = 0.0
        }
    }
    
    func showErrorView() {
        UIView.animate(withDuration: errorViewAnimationDuration) {
            self.errorView.alpha = 1.0
        }
    }
    
    func initializeRefreshButton() {
        refreshButton.titleLabel?.text = String.localizedStringWithKey(peopleViewControllerRefreshButtonKey)
        refreshButton.backgroundColor = UIColor.peopleYellowColor()
        refreshButton.titleLabel?.font = UIFont.avenirNext15Medium()
        refreshButton.layer.cornerRadius = 10
    }
    
    func initializeNavigationBar() {
        self.navigationItem.title = String.localizedStringWithKey(peopleViewControllerTitleKey)
        self.navigationController?.navigationBar.backgroundColor = UIColor.peopleYellowColor()
    }
    
    func initializeTableView() {
        addRefreshControlToTableView()
        userTableView.tableFooterView = UIView()
    }
    
    func initializeErrorViews() {
        errorLabel.font = UIFont.avenirNext15Medium()
        errorView.alpha = 0
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

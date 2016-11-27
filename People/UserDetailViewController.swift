//
//  UserDetailViewController.swift
//  People
//
//  Created by Lubomir Klucka on 27/11/2016.
//  Copyright © 2016 luboklucka. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    // MARK: - Constants and variables
    var user: User?

    // MARK: - IBOutlets
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    // MARK: - IBActions
    
    // MARK: - UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = user?.name
        initializeLabels()
    }

    // MARK: - Custom functions
    func initializeLabels() {
        username.font = UIFont.avenirNext15Medium()
        email.font = UIFont.avenirNext15Medium()
        phone.font = UIFont.avenirNext15Medium()
        
        username.text = user?.username
        email.text = user?.email
        phone.text = user?.phone
    }
}

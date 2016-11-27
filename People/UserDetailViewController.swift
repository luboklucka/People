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
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    // MARK: - IBActions
    
    // MARK: - UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        name.text = user?.name
        email.text = user?.email
        username.text = user?.username
        phone.text = user?.phone
    }

    // MARK: - Custom functions
    
}

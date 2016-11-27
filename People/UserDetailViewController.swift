//
//  UserDetailViewController.swift
//  People
//
//  Created by Lubomir Klucka on 27/11/2016.
//  Copyright © 2016 luboklucka. All rights reserved.
//

import UIKit
import MapKit

class UserDetailViewController: UIViewController {
    // MARK: - Constants and variables
    var user: User?
    let regionRadius: CLLocationDistance = 10000000

    // MARK: - IBOutlets
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    // MARK: - IBActions
    
    // MARK: - UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = user?.name
        initializeLabels()
        initializeMapView()
    }

    // MARK: - Custom functions
    func initializeLabels() {
        username.font = UIFont.avenirNext14Regular()
        email.font = UIFont.avenirNext14Regular()
        phone.font = UIFont.avenirNext14Regular()
        
        username.text = user?.username
        email.text = user?.email
        phone.text = user?.phone
    }
    
    func initializeMapView() {
        if Double(user!.address.geoLocation.latitude) != nil && Double(user!.address.geoLocation.longitude) != nil {
            let initialLocation = CLLocation(latitude: Double(user!.address.geoLocation.latitude)!, longitude: Double(user!.address.geoLocation.longitude)!)
            
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                                                                      regionRadius, regionRadius)
            map.setRegion(coordinateRegion, animated: true)
        } else {
            map.isHidden = true
        }
    }
}

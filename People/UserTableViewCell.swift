//
//  UserTableViewCell.swift
//  People
//
//  Created by Lubomir Klucka on 27/11/2016.
//  Copyright © 2016 luboklucka. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.textLabel?.font = UIFont.avenirNext14Regular()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }

}

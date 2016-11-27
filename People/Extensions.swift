//
//  Extensions.swift
//  People
//
//  Created by Lubomir Klucka on 27/11/2016.
//  Copyright © 2016 luboklucka. All rights reserved.
//

import UIKit

extension UIFont {
    static func avenirNext14Regular() -> UIFont {
        return UIFont(name: "AvenirNext-Regular", size: 14.0)!
    }
    
    static func avenirNext15Medium() -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: 15.0)!
    }
}

extension UIColor {
    // Colors go here ...
}

extension String {
    static func localizedStringWithKey(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

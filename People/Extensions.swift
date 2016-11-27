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
    static func colorWithRed(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static func peopleYellowColor() -> UIColor {
        return UIColor.colorWithRed(254, green: 226, blue: 74)
    }
    
    static func peopleOrangeColor() -> UIColor {
        return UIColor.colorWithRed(254, green: 195, blue: 59)
    }
}

extension String {
    static func localizedStringWithKey(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

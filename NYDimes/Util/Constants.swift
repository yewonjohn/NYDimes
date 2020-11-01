//
//  String.swift
//  NYDimes
//
//  Created by John Kim on 10/21/20.
//

import Foundation
import UIKit

struct Const{
    
    static let accountSettingsLabel = ["Search History", "Password", "Rate Us", "App Feedback", "Logout"]
    static let accountSettingsImages = [#imageLiteral(resourceName: "History"),#imageLiteral(resourceName: "Password"),#imageLiteral(resourceName: "Rate"),#imageLiteral(resourceName: "Comment"),#imageLiteral(resourceName: "Logout")]
    
    struct Articles {
        static let typePickerData = ["emailed","shared","viewed"]
        static let daysPickerData = [1,7,30]
        
    }
    
    struct Movies {
        static let typePickerData = ["all","picks"]
        static let orderPickerData = ["by release","by published","by title"]
        
    }
    
    struct API {
        
        static let apiKey = "xhCbQFpLJv0wgUALuxi21dzp3pl873cb"
        
    }
}

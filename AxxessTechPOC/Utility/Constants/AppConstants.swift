//
//  AppConstants.swift
//  AxxessTechPOC
//
//  Created by Rajesh Deshmukh on 25/08/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit

class AppConstants {
    
    ///  List of all API URLS
    
    struct EndPoints {
        static let testUrl = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    }
    
    ///  List of all literal Strings
    
    struct LiteralString {
        static let errorTitle = "Error"
        static let errorMsg = "Failed to load data from server."
        static let noRecordsErrorMsg = "No Records available"
        static let okBtn = "OK"
        static let navTitle = "Facts"
        
    }
    
    ///  List of all color codes
    
    struct AppColor {
        static let kColor_black = UIColor.black
        static let kColor_DarkGray = UIColor.darkGray
    }
    
    ///  List of all fonts
    
    struct AppFonts {
        static let kboldSystemFont16 = UIFont.boldSystemFont(ofSize: 16)
        static let ksystemFont14 = UIFont.systemFont(ofSize: 14)
    }
    
    ///  List of all cell identifires
    
    struct CellIdentifire {
        static let kFactsTableViewCellId = "FactsTableViewCell"
    }
    
    ///  List of all Images
    
     struct AppImage {
       static let placeholder = "placeholder"
     }
    
}


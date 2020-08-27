//
//  DBModel.swift
//  AxxessTechPOC
//
//  Created by Rajesh Deshmukh on 27/08/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation
import RealmSwift

class DBModel: Object {
    
    @objc dynamic var id : String?
    @objc dynamic var type : String?
    @objc dynamic var date : String?
    @objc dynamic var data : String?
    @objc dynamic var imagePath: String?
    
}

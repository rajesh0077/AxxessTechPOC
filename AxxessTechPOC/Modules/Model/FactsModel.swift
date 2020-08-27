//
//  FactsModel.swift
//  AxxessTechPOC
//
//  Created by Rajesh Deshmukh on 25/08/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation

struct FactsModel : Codable {
    
    let id : String?
    let type : String?
    let date : String?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case type = "type"
        case date = "date"
        case data = "data"
        
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        date = try values.decodeIfPresent(String.self, forKey: .date) ?? ""
        data = try values.decodeIfPresent(String.self, forKey: .data) ?? ""
        
    }

    init(dbObj: DBModel) {
        
        id = dbObj.id
        type = dbObj.type
        date = dbObj.date
        data = dbObj.data
        
    }
    
}

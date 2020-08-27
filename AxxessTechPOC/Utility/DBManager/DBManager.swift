//
//  DBManager.swift
//  AxxessTechPOC
//
//  Created by Rajesh Deshmukh on 26/08/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    
    private init() {}
    static let shared = DBManager()
    
    var modelObj: DBModel?
    
    /// method used to insert Data into DB
    
    func saveData(dataObj: FactsModel) {
        
        modelObj = DBModel()
        modelObj?.id = dataObj.id
        modelObj?.type = dataObj.type
        modelObj?.date =  dataObj.date
        
        if dataObj.type == "image" {
             modelObj?.imagePath =  modelObj?.id ?? ""
             modelObj?.data = ""
        } else {
            modelObj?.data = dataObj.data
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(modelObj ?? DBModel())
        }
        
    }
    
     /// method used for fetch Data from DB
    
    func fetchData() -> [FactsModel] {
        
        let realm = try! Realm()
        let items = realm.objects(DBModel.self)
        var facts = [FactsModel]()
        
        for item in items {
            let factsObj =  FactsModel(dbObj: item)
            facts.append(factsObj)
        }
        return facts
        
    }
    
}

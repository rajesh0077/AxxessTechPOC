//
//  FactsViewModel.swift
//  AxxessTechPOC
//
//  Created by Rajesh Deshmukh on 25/08/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation

class FactsViewModel {
    
    var respoceObj: [FactsModel]?
    
    func getNavTitle() -> String {
        return AppConstants.LiteralString.navTitle
    }
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getNumberOfRows() -> Int {
        return getTotalNumberOfFacts()
    }
    
    func getTotalNumberOfFacts() -> Int {
        return respoceObj?.count ?? 0
    }
    
    func getPerticularFactAtIndexPath(indexPath: IndexPath) -> FactsModel? {
        return respoceObj?[indexPath.row]
    }
    
    func fetchFacts <T: Decodable>(resultType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL.init(string: AppConstants.EndPoints.testUrl) else { return }
        
        NetworkManager.shared.performRequest(requestUrl: url, resultType: [FactsModel].self) { result in
            
            switch(result) {
            case .success(let result):
                self.respoceObj = result
                DirectoryManager.shared.clearTempFolder()
                self.saveDataForOfflineMode()
                completion(.success(result as! T))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveDataForOfflineMode() {
        let lenght =  self.respoceObj?.count ?? 0
        for i  in 0..<lenght {
            if let singleItem = respoceObj?[i] {
                DBManager.shared.saveData(dataObj: singleItem)
            }
        }
    }
    
    func fetchDataForOfflineMode() {
        self.respoceObj =  DBManager.shared.fetchData()
    }
    
}

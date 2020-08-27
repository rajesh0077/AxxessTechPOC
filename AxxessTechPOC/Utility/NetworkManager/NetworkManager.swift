//
//  NetworkManager.swift
//  AxxessTechPOC
//
//  Created by Rajesh Deshmukh on 25/08/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation

import Alamofire

class NetworkManager {
    
    private init() {}
    
    static let shared = NetworkManager()
    
    
    /// Using URLSession
    
    func performURLSessionRequest<T: Decodable>(requestUrl: URL, resultType: T.Type , completion: @escaping (Result<T, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            if let err = error {
                completion(.failure(err))

            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    /// Using Alamofire
    
    func performRequest<T: Decodable>(requestUrl: URL, resultType: T.Type , completion: @escaping (Result<T, Error>) -> Void) {
        
        let request = AF.request(requestUrl.absoluteString)
        request.responseJSON { (response) in
            
            guard let data = response.data else { return }
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        
    }
    
}

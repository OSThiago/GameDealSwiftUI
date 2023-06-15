//
//  WorkerCheapShark.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import Foundation

class WorkerCheapShark {
    
    func getDealsList(endpoint: Endpoint, completion: @escaping (Result<[FeedGameDeal] ,ServiceError>) -> ()) {
        
        let session = URLSession.shared
        
        let url = URL(string: endpoint.url)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.httpMethod
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            if let data {
                
                do {
                    let data = try JSONDecoder().decode([FeedGameDeal].self, from: data)
                    
                    completion(.success(data))
                    
                } catch let error {
                    completion(.failure(ServiceError.network(error)))
                }
            }
        }
        task.resume()
    }
    
    func getDealLookup(endpoint: Endpoint, completion: @escaping (FeedGameDeal?) -> ()) {
        
    }
    
    func getGameLookup(endpoint: Endpoint, completion: @escaping (FeedGameDeal) -> ()) {
        
    }
    
    func getStores(completion: @escaping (Result<[StoresCheapShark], ServiceError>) -> ()) {
        
        // Request
        let endpoint = EndpointCasesCheapShark.getStores
        
        let url = URL(string: endpoint.url)!
        
        print(url)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.httpMethod
        
        // Session task
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if let data {
                do {
                    // Decode Json
                    let data = try JSONDecoder().decode([StoresCheapShark].self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(ServiceError.network(error)))
                }
            }
            
        }
        dataTask.resume()
    }
}

//
//  WorkerCheapShark.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import Foundation

class WorkerCheapShark {
    
    func getDealsList(endpoint: Endpoint, completion: @escaping (Result<[FeedGameDealModel] ,ServiceError>) -> ()) {
        
        let session = URLSession.shared
        
        let url = URL(string: endpoint.url)!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.httpMethod
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            if let data {
                
                do {
                    let data = try JSONDecoder().decode([FeedGameDealModel].self, from: data)
                    
                    completion(.success(data))
                    
                } catch let error {
                    completion(.failure(ServiceError.network(error)))
                }
            }
        }
        task.resume()
    }
    
    func getDealLookup(endpoint: Endpoint, completion: @escaping (FeedGameDealModel?) -> ()) {
        
    }
    
    func getGameLookup(endpoint: Endpoint, completion: @escaping (Result<GameLookupModel, ServiceError>) -> ()) {
        
        let session = URLSession.shared

        let url = URL(string: endpoint.url)!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = endpoint.httpMethod
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let data {
                do {
                    let data = try JSONDecoder().decode(GameLookupModel.self, from: data)

                    #warning("Ver o que diabos ta dando erro no decode")

                    completion(.success(data))
                } catch let error {
                    completion(.failure(ServiceError.network(error)))
                }
            }
        }
        task.resume()
    }
    
    func getStores(completion: @escaping (Result<[StoresCheapShark], ServiceError>) -> ()) {
        
        // Request
        let endpoint = EndpointCasesCheapShark.getStores
        
        let url = URL(string: endpoint.url)!
        
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

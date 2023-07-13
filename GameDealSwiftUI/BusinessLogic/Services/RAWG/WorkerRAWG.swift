//
//  WorkerRAWG.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 10/07/23.
//

import Foundation

class WorkerRAWG {
    func getGameDetail(endpoint: Endpoint, completion: @escaping (Result<RwGameDetailModel, ServiceError>) -> ()) {
        
        let session = URLSession.shared
        
        guard let url = URL(string: endpoint.url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.httpMethod
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            if let data {
                do {
                    
                    let decoder = JSONDecoder()
                    // Formatting data snake_Case to CamelCase
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let data = try decoder.decode(RwGameDetailModel.self, from: data)
                    
                    completion(.success(data))
                    
                } catch let error {
                    completion(.failure(.network(error)))
                }
            }
        }
        task.resume()
    }
}

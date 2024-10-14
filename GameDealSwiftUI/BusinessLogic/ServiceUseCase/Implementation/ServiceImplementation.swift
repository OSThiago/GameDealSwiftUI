//
//  ServiceImplementation.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/10/24.
//

import Foundation

struct ServiceImplementation: ServiceProtocol {
    func fetch<T : Codable>(endpoint: any EndPointProtocol) async throws -> T {
        let session = URLSession.shared
        
        guard let url = URL(string: endpoint.getUrl()) else {
            throw ServiceError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.httpMethod
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ServiceError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ServiceError.network(error)
        }
    }
}

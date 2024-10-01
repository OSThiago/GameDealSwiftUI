//
//  CSDealsServiceImpelentation.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/09/24.
//
import Foundation

struct CSDealsServiceImpelentation: DealsProtocol {
    func dealsList(endPoint: EndPointProtocol) async throws -> [DealModel] {
        return try await getRequest(endpoint: endPoint)
    }
    
    func dealLookup(endPoint: EndPointProtocol) async throws -> DealModel {
        return try await getRequest(endpoint: endPoint)
    }
    
    private func getRequest<T : Codable>(endpoint: EndPointProtocol) async throws -> T {
        let session = URLSession.shared
        
        guard let url = URL(string: self.url(endpoint: endpoint)) else {
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
    
    func url(endpoint: EndPointProtocol) -> String {
        var query = ""
        
        for item in endpoint.query {
            query.append("&\(item.description)")
        }

        let url = "\(endpoint.baseURL)\(endpoint.path)\(query)"
        
        return url
    }
}

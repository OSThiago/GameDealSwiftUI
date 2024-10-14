//
//  EndPointProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/09/24.
//

import Foundation

protocol EndPointProtocol {
    var baseURL: String { get }
    var httpMethod: String { get }
    var path: String { get }
    var query: [URLQueryItem] { get }
}

extension EndPointProtocol {
    func getUrl() -> String {
        var query = ""

        for item in self.query {
            query.append("&\(item.description)")
        }

        let url = "\(self.baseURL)\(self.path)\(query)"

        return url
    }
    
//    func getRequest<T : Codable>() async throws -> T {
//        let session = URLSession.shared
//        
//        guard let url = URL(string: self.getUrl()) else {
//            throw ServiceError.invalidURL
//        }
//        
//        var urlRequest = URLRequest(url: url)
//        
//        urlRequest.httpMethod = self.httpMethod
//        
//        let (data, response) = try await session.data(for: urlRequest)
//        
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw ServiceError.invalidResponse
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            return try decoder.decode(T.self, from: data)
//        } catch {
//            throw ServiceError.network(error)
//        }
//    }
}

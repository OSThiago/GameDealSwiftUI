//
//  AlertsEndPoint.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 02/02/25.
//

import Foundation

enum AlertsEndPoint {
    case set(email: String, gameID: Int, price: Double)
    case remove(email: String, gameID: Int)
}

extension AlertsEndPoint: EndPointProtocol {
    var baseURL: String {
        return BaseURL.cheapsharkURL
    }
    
    var httpMethod: String {
        return "POST"
    }
    
    var path: String {
        return "/api/1.0/alerts?"
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .set(let email, let gameID, let price):
            var query: [URLQueryItem] = []
            query.append(AlertsQuery.action(action: "set").queryItem)
            query.append(AlertsQuery.email(email: email).queryItem)
            query.append(AlertsQuery.gameID(id: gameID).queryItem)
            query.append(AlertsQuery.price(price: price).queryItem)
            return query
        case .remove(let email, let gameID):
            var query: [URLQueryItem] = []
            query.append(AlertsQuery.action(action: "delete").queryItem)
            query.append(AlertsQuery.email(email: email).queryItem)
            query.append(AlertsQuery.gameID(id: gameID).queryItem)
            return query
        }
    }
}

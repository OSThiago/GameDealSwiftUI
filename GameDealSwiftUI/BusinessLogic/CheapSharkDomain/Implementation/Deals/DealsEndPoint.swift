//
//  DealsEndPoint.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/09/24.
//

import Foundation

enum DealsEndPoint {
    case dealsList(queryItens: [DealsQuery])
    case dealLookup(id: String)
}

extension DealsEndPoint: EndPointProtocol {
    var baseURL: String {
        return BaseURL.cheapsharkURL
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    var path: String {
        return "/api/1.0/deals?"
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .dealsList(let queryItens):
            var query: [URLQueryItem] = []
            for iten in queryItens {
                query.append(iten.queryItem)
            }
            return query
        case .dealLookup(let id):
            return [URLQueryItem(name: "id", value: id)]
        }
    }
}

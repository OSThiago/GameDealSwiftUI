//
//  GamesEndPoint.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 01/10/24.
//

import Foundation

enum GamesEndPoint {
    case gamesList(queryItens: [GameQuery])
    case gameLookup(id: String)
    case multipleGameLookup(ids: [String])
}

extension GamesEndPoint: EndPointProtocol {
    var baseURL: String {
        return BaseURL.cheapsharkURL
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    var path: String {
        return "/api/1.0/games?"
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .gamesList(let queryItens):
            return queryItens.map { $0.queryItem }
        case .gameLookup(let id):
            return [URLQueryItem(name: "id", value: id)]
        case .multipleGameLookup(let ids):
            let value = ids.joined(separator: ",")
            return [URLQueryItem(name: "id", value: value)]
        }
    }
}

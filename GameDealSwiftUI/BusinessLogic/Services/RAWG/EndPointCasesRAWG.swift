//
//  EndPointCasesRAWG.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 10/07/23.
//

import Foundation

enum EndpointCasesRAWG: Endpoint  {
    case getGameDetail(name: String)
    case searchGame(name: String)
    
    var baseURLString: String {
        return BaseURL.rawgURL
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    var path: String {
        switch self {
        case .getGameDetail(let name):
            return "/api/games/\(name)?"
        case .searchGame(name: let name):
            return "/api/games?search=\(name)&"
        }
    }
    
    var query: String? {
        return nil
    }
    
    var key: String? {
        return "ddbef2791b5f483b9e8f0c8f01691c20"
    }
}

// https://api.rawg.io/api/games/Mortal-Kombat-XL?key=ddbef2791b5f483b9e8f0c8f01691c20

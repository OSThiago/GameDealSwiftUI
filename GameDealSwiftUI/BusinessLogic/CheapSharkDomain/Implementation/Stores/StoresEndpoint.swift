//
//  StoresEndpoint.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/10/24.
//

import Foundation

enum StoresEndpoint {
    case storesInformation
}

extension StoresEndpoint: EndPointProtocol {
    var baseURL: String {
        return BaseURL.cheapsharkURL
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    var path: String {
        return "/api/1.0/stores"
    }
    
    var query: [URLQueryItem] {
        return []
    }
}

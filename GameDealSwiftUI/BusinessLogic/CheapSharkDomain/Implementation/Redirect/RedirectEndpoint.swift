//
//  RedirectEndpoint.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 06/01/25.
//

import Foundation

enum RedirectEndpoint {
    case webLink(dealID: String)
}

extension RedirectEndpoint: EndPointProtocol {
    var baseURL: String {
        BaseURL.cheapsharkURL
    }
    
    var httpMethod: String {
        return ""
    }
    
    var path: String {
        return "/redirect?"
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .webLink(dealID: let dealID):
            return [URLQueryItem(name: "ID", value: dealID)]
        }
    }
}

// https://www.cheapshark.com/redirect?dealID=8JWQ51DVapSJnGVviMI0Hgu4YFqxme2sBdLD3vh6dZw%3D

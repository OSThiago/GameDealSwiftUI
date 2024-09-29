//
//  Endpoint.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import Foundation

protocol Endpoint {
    var baseURLString: String { get }
    var httpMethod: String { get }
    var path: String { get }
    var query: String? { get }
    var key: String? { get }
}

extension Endpoint {
    
    var url: String {
        
        var url = baseURLString + path
        
        if let query {
            url.append(query)
        }
        
        if let key {
            url.append(formatedKey(key: key))
        }
        
        return url
    }

    private func formatedKey(key: String) -> String {
        return "key=\(key)"
    }
}

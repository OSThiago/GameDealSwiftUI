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
}

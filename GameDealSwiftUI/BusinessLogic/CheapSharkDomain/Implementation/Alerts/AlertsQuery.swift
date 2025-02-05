//
//  AlertsQuery.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 02/02/25.
//

import Foundation

enum AlertsQuery {
    case action(action: String)
    case email(email: String)
    case gameID(id: Int)
    case price(price: Double)
}

extension AlertsQuery {
    var queryItem: URLQueryItem {
        switch self {
        case .action(let action):
            URLQueryItem(name: "action", value: action)
        case .email(let email):
            URLQueryItem(name: "email", value: email)
        case .gameID(let id):
            URLQueryItem(name: "gameID", value: String(id))
        case .price(let price):
            URLQueryItem(name: "price", value: String(price))
        }
    }
}

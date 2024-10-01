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

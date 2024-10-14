//
//  ServiceProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/10/24.
//

import Foundation

protocol ServiceProtocol {
    func fetch<T : Codable>(endpoint: EndPointProtocol) async throws -> T
    // TODO: Add Post method for alerts
}

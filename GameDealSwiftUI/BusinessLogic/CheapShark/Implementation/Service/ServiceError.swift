//
//  ServiceError.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case invalidResponse
    case network(Error?)
}

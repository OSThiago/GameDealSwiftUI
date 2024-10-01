//
//  DealsProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/09/24.
//
import Foundation

protocol DealsProtocol {
    func dealsList(endPoint: EndPointProtocol) async throws -> [DealModel]
    func dealLookup(endPoint: EndPointProtocol) async throws -> DealModel
}

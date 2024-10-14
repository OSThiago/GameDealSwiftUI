//
//  DealsProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/09/24.
//
import Foundation

protocol DealsProtocol {
    func dealsList(endPoint: DealsEndPoint) async throws -> [DealModel]
    func dealLookup(endPoint: DealsEndPoint) async throws -> DealModel
}

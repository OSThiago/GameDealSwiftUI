//
//  CSDealsServiceImpelentation.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/09/24.
//
import Foundation

struct DealsServiceImpelentation: DealsProtocol {
    
    @Injected private var serviceUseCase: ServiceProtocol
    
    func dealsList(endPoint: DealsEndPoint) async throws -> [DealModel] {
        return try await serviceUseCase.fetch(endpoint: endPoint)
    }
    
    func dealLookup(endPoint: DealsEndPoint) async throws -> DealModel {
        return try await serviceUseCase.fetch(endpoint: endPoint)
    }
}

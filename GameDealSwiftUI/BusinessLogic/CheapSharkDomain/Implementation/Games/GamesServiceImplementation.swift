//
//  GamesServiceImplementation.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/10/24.
//
import Foundation

struct GamesServiceImplementation: GamesProtocol {

    @Injected private var serviceUseCase: ServiceProtocol

    func gamesList(endpoint: GamesEndPoint) async throws -> [GameModel] {
        return try await serviceUseCase.fetch(endpoint: endpoint)
    }
    
    func gameLookup(endpoint: GamesEndPoint) async throws -> GameLookupModel {
        return try await serviceUseCase.fetch(endpoint: endpoint)
    }
    
    func multipleGameLookup(endpoint: GamesEndPoint) async throws -> [GameLookupModel] {
        return try await serviceUseCase.fetch(endpoint: endpoint)
    }
}

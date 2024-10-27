//
//  GamesProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/09/24.
//
import Foundation

protocol GamesProtocol {
    func gamesList(endpoint: GamesEndPoint) async throws -> [GameModel]
    func gameLookup(endpoint: GamesEndPoint) async throws -> GameLookupModel
    func multipleGameLookup(endpoint: GamesEndPoint) async throws -> [GameLookupModel]
}

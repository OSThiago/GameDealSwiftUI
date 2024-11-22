//
//  CoreDataUseCase.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import Foundation
import CoreData


protocol CoreDataUseCaseProtocol {
    func fetchAllFavoriteGames() throws -> [FavoriteGame]
    func fetchFavoriteGame(gameID: String) -> FavoriteGame?
    func createFavoriteGame(gameID: String) throws
    func deleteFavoriteGame(gameID: String) throws
    func updateFavoriteGame(edittedGame: FavoriteGame)
    func save()
}

class CoreDataUseCaseImplementation: CoreDataUseCaseProtocol {

    private let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Loading persistent stores failed: \(error)")
            } else {
                print("Succeeded loading Core data")
            }
        }
    }

    func fetchAllFavoriteGames() throws -> [FavoriteGame] {
        let request = NSFetchRequest<FavoriteGame>(entityName: FavoriteGame.entityName)

        do {
            return try container.viewContext.fetch(request)
        } catch {
            throw error
        }
    }

    func fetchFavoriteGame(gameID: String) -> FavoriteGame? {
        let request = NSFetchRequest<FavoriteGame>(entityName: FavoriteGame.entityName)

        do {
            let games = try fetchAllFavoriteGames()
            
            guard let game = games.first(where: { $0.gameID == gameID }) else { return nil }
            
            return game
        } catch {
            return nil
        }
    }

    func createFavoriteGame(gameID: String) throws {
        let game = FavoriteGame(context: container.viewContext)
        game.gameID = gameID
        game.dateAdded = Date()
        game.isActiveNotification = false
        save()
    }

    func deleteFavoriteGame(gameID: String) throws {
        do {
            let favoriteGames = try fetchAllFavoriteGames()
            
            if let favoriteGame = favoriteGames.first(where: { $0.gameID == gameID }) {
                container.viewContext.delete(favoriteGame)
                save()
            }
        } catch {
            throw error
        }
    }

    func updateFavoriteGame(edittedGame: FavoriteGame) {
        guard let gameID = edittedGame.gameID else { return }

        if let currentGame = fetchFavoriteGame(gameID: gameID) {
            // TODO: - Add more Attributes here
            /// game id and created date should never change
            currentGame.isActiveNotification = edittedGame.isActiveNotification
            save()
        }
    }

    func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving Core data: \(error)")
        }
    }
}

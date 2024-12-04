//
//  CoreDataProvider.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import CoreData
import Foundation

class CoreDataUseCase {
    static let shared = CoreDataUseCase()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load Core Data store: \(error)")
            }
        }
    }
    
    private func save() throws {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving Core Data: \(error)")
            throw error
        }
    }
    
    func addFavoriteGame(gameID: String) throws {
        let favoriteGame = FavoriteGame(context: container.viewContext)
        favoriteGame.gameID = gameID
        favoriteGame.dateAdded = Date()
        favoriteGame.notificationIsActive = false
        try self.save()
    }
    
    func getFavoriteGames() throws -> [FavoriteGame] {
        return try container.viewContext.fetch(FavoriteGame.fetchRequest())
    }
    
    func getFavoriteGame(for gameID: String) throws -> FavoriteGame? {
        let allFavoriteGames = try getFavoriteGames()
        return allFavoriteGames.first(where: { $0.gameID == gameID })
//        let fetchRequest: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "gameID == %@", gameID)
//        if let favoriteGame = try container.viewContext.fetch(fetchRequest).first {
//            return favoriteGame
//        }
//        return nil
    }
    
    func updateAlertStatus(for gameID: String, isActive: Bool) throws {
        if let favoriteGame = try? getFavoriteGame(for: gameID) {
            favoriteGame.notificationIsActive = isActive
            try self.save()
        } else {
            print("game id not found")
        }
    }
    
    func deleteFavoriteGame(gameID: String) throws {
        if let favoriteGame = try? getFavoriteGame(for: gameID) {
            container.viewContext.delete(favoriteGame)
            try save()
        } else {
            print("game id not found")
        }
    }
    
    func containsFavoriteGame(gameID: String) -> Bool {
        do {
            return try getFavoriteGame(for: gameID) != nil
        } catch {
            return false
        }
    }
}

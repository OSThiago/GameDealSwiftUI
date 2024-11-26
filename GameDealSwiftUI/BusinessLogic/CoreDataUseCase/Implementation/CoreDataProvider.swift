//
//  CoreDataProvider.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import CoreData
import Foundation

class CoreDataProvider {
    static let shared = CoreDataProvider()
    
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
//        let request: NSFetchRequest<FavoriteGame> = FavoriteGame.fetchRequest()
//        return try container.viewContext.fetch(request)
//        do {
            return try container.viewContext.fetch(FavoriteGame.fetchRequest())
//        } catch {
//            throw error
//        }
    }
}

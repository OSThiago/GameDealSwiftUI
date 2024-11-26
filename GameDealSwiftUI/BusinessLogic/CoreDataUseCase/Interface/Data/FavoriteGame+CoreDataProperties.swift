//
//  FavoriteGame+CoreDataProperties.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//
//

import Foundation
import CoreData


extension FavoriteGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteGame> {
        return NSFetchRequest<FavoriteGame>(entityName: "FavoriteGame")
    }

    @NSManaged public var gameID: String
    @NSManaged public var notificationIsActive: Bool
    @NSManaged public var dateAdded: Date

}

extension FavoriteGame : Identifiable {

}

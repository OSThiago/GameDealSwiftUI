//
//  GameQuery.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 01/10/24.
//

import Foundation

enum GameQuery {
    /// (required, string)
    /// Search for a game by title, case insensitive (required when not specifying steamAppID)
    case title(title: String)
    
    /// (optional, integer) Default 60
    /// The maximum number of games to return, up to 60
    case limit(limit: Int)
    
    /// (optional, integer)
    /// Instead of using title, you can search for a game by Steam’s AppID - e.g. http://store.steampowered.com/app/35140/
    case steamAppID(id: Int)
    
    /// (optional, boolean) Default 0
    /// Flag to allow only exact string match for title parameter
    case exact(isActive: Bool)
}

//
//  AppScene.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/24.
//

import SwiftUI

enum AppScene {
    case feed
    case listDeal(store: StoresCheapShark)
    case dealDetail(feedGameDealModel: FeedGameDealModel,
                    store: StoresCheapShark)
    case search
    case gameDetail(gameID: String)
}

// MARK: - Hashble
extension AppScene: Hashable {
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .feed:
            hasher.combine("")
        case .listDeal(_):
            hasher.combine("")
        case .dealDetail(_,_):
            hasher.combine("")
        case .search:
            hasher.combine("")
        case .gameDetail(gameID: let gameID):
            hasher.combine("")
        }
    }
    
    static func == (lhs: AppScene, rhs: AppScene) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

// MARK: - Sheet
enum Sheet: Hashable, Identifiable {

    case gameDetail(gameID: String)
    
    var id: String {
        switch self {
        case .gameDetail(let gameID):
            "gameDetail"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine("")
    }
    
    static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

// MARK: - FullScreenCover
enum FullScreenCover: Hashable, Identifiable {
    case gameDetail(gameID: String)
    
    var id: String {
        switch self {
        case .gameDetail(let gameID):
            "gameDetail"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine("")
    }
    
    static func == (lhs: FullScreenCover, rhs: FullScreenCover) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

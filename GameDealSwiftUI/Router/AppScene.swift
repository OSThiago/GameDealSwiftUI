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
        }
    }
    
    static func == (lhs: AppScene, rhs: AppScene) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

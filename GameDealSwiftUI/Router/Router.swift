//
//  Router.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/24.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    // Page
    func push(_ scene: AppScene) {
        self.path.append(scene)
    }
    
    func pop() {
        self.path.removeLast()
    }
    
    func popToRoot() {
        self.path.removeLast(path.count)
    }
    
    // Sheet
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    // FullScreenCover
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
}

// MARK: - View
extension Router {
    @ViewBuilder
    func buildedView(scene: AppScene) -> some View {
        switch scene {
        case .feed:
            FeedConfigurator().configure()
        case .listDeal(let store):
            ListDealsConfigurator(store: store).configure()
        case .dealDetail(let feedGameDealModel, let store):
            DealLookupConfigurator(feedGameDealModel: feedGameDealModel,
                                   store: store).configure()
        case .search:
            SearchConfigurator().configure()
        case .gameDetail(gameID: let gameID):
            GameDetailConfigurator(gameId: gameID).configure()
        case .profile:
            ProfileConfigurator().configure()
        }
    }
    
    @ViewBuilder
    func buildedView(sheet: Sheet) -> some View {
        switch sheet {
        case .gameDetail(let gameID):
            GameDetailConfigurator(gameId: gameID).configure()
        }
    }
    
    @ViewBuilder
    func buildedView(fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        case .gameDetail(let gameID):
            GameDetailConfigurator(gameId: gameID).configure()
        }
    }
}

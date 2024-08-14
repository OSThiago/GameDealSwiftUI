//
//  Router.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/24.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    func push(_ scene: AppScene) {
        self.path.append(scene)
    }
    
    func pop() {
        self.path.removeLast()
    }
    
    func popToRoot() {
        self.path.removeLast(path.count)
    }
}

// MARK: - View
extension Router {
    @ViewBuilder
    func buildedView(scene: AppScene) -> some View {
        switch scene {
        case .feed:
            FeedConfigurator().configure()
        case .listDeal(let store, let storesInformations):
            ListDealsConfigurator(store: store, storesInformations: storesInformations).configure()
        case .dealDetail(let feedGameDealModel):
            DealLookupConfigurator(feedGameDealModel: feedGameDealModel).configure()
        }
    }
}

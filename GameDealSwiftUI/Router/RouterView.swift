//
//  RouterView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/24.
//

import SwiftUI

struct RouterView: View {
    
    @StateObject private var router = Router()
    
    private var initialScene: AppScene
    
    init(initialScene: AppScene = .feed) {
        self.initialScene = initialScene
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            router.buildedView(scene: initialScene)
                .navigationDestination(for: AppScene.self) { scene in
                    router.buildedView(scene: scene)
                }
                .sheet(item: $router.sheet) { sheet in
                    router.buildedView(sheet: sheet)
                }
                .fullScreenCover(item: $router.fullScreenCover) { fullScreenCover in
                    router.buildedView(fullScreenCover: fullScreenCover)
                }
        }
        .environmentObject(router)
    }
}

struct TabBarView: View {
    var body: some View {
        TabView {
            RouterView()
            .tabItem {
                Label {
                    Text("Today")
                } icon: {
                    Image(systemName: "doc.text.image")
                        .resizable()
                }
            }
            
            RouterView(initialScene: .search)
                .tabItem {
                    Label {
                        Text("Seach")
                    } icon: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                    }
                }
        }
    }
}

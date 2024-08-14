//
//  RouterView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/24.
//

import SwiftUI

struct RouterView: View {
    
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            router.buildedView(scene: .feed)
                .navigationDestination(for: AppScene.self) { scene in
                    router.buildedView(scene: scene)
                }
        }
        .environmentObject(router)
    }
}

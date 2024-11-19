//
//  GameDetailView+DismissButton.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 19/11/24.
//

import SwiftUI

extension GameDetailView {
    var dismissButton: some View {
        Button {
            router.dismissFullScreenCover()
        } label: {
            Image(systemName: "x.circle.fill")
                .tint(.white)
                .shadow(color: .black, radius: 4)
                .scaleEffect(1.5)
        }
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126").configure()
}

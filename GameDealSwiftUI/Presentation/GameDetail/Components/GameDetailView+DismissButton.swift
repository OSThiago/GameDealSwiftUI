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
            Image(systemName: constants.dismissButtonImage)
                .tint(.white)
                .shadow(color: .black, radius: Tokens.borderRadius.sm)
                .scaleEffect(constants.dismissButtonScaleEffect)
        }
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126").configure()
}

//
//  GameDetailView+HeaderSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 19/11/24.
//

import SwiftUI

extension GameDetailView {
    @ViewBuilder
    var headerSection: some View {
        VStack(alignment: .leading, spacing: Tokens.padding.xxxs) {
            if let thumb = viewModel.gameLookupModel?.info?.thumb {
                GameImage(url: thumb,
                          width: ScreenSize.width,
                          height: constants.gameImageHeight,
                          placeholder: constants.imagePlaceholder)
            }
            
            VStack(alignment: .leading, spacing: Tokens.padding.quarck) {
                Text(viewModel.gameLookupModel?.info?.title ?? constants.error)
                    .font(.title3)
                    .fontWeight(.bold)

                HStack {
                    cheapestPriceEver
                        .padding(.top, Tokens.padding.xxs)
                    
                    Spacer()
                    
                    Button {
                        viewModel.favoriteAction()
                    } label: {
                        Image(systemName: viewModel.isFavorite ? constants.favoriteFillImage : constants.favoriteImage)
                    }
                }
            }
            .padding(.horizontal, Tokens.padding.xxxs)
        }
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126", onDisappear: nil).configure()
}

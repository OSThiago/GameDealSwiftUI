//
//  GameDetailView+HeaderSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 19/11/24.
//

import SwiftUI

extension GameDetailView {
    var headerSection: some View {
        VStack(alignment: .leading, spacing: Tokens.padding.xxxs) {
            let hightQualityImage = viewModel.formatterUseCase.getHightQualityImage(url: viewModel.gameLookupModel?.info?.thumb ?? constants.error)
            
            GameImage(url: hightQualityImage,
                      width: ScreenSize.width,
                      height: constants.gameImageHeight,
                      placeholder: constants.imagePlaceholder)
            
            VStack(alignment: .leading, spacing: Tokens.padding.quarck) {
                Text(viewModel.gameLookupModel?.info?.title ?? constants.error)
                    .font(.title3)
                    .fontWeight(.bold)

                HStack {
                    cheapestPriceEver
                        .padding(.top, Tokens.padding.xxs)
                    
                    Spacer()
                    
                    Button {
                        do {
                            if viewModel.isFavorite {
                                try CoreDataUseCase.shared.deleteFavoriteGame(gameID: viewModel.gameId)
                            } else {
                                try CoreDataUseCase.shared.addFavoriteGame(gameID: viewModel.gameId)
                            }
                        } catch {
                            print(error)
                        }
                        
                        viewModel.updateIsFavorite()
                    } label: {
                        Image(systemName: viewModel.isFavorite ? "heart.fill" :"heart")
                    }

                }
            }
            .padding(.horizontal, Tokens.padding.xxxs)
        }
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126").configure()
}


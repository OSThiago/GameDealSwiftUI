//
//  GameDetailView+HeaderSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 19/11/24.
//

import SwiftUI

extension GameDetailView {
    var headerSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            let hightQualityImage = viewModel.formatterUseCase.getHightQualityImage(url: viewModel.gameLookupModel?.info?.thumb ?? "error")
            
            GameImage(url: hightQualityImage,
                      width: ScreenSize.width,
                      height: ScreenSize.width / 16*9,
                      placeholder: "photo.artframe")
            
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.gameLookupModel?.info?.title ?? "error")
                    .font(.title3)
                    .fontWeight(.bold)

                cheapestPriceEver
                    .padding(.top, 24)
                
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126").configure()
}


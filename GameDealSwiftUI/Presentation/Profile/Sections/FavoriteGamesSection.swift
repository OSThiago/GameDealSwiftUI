//
//  FavoriteGamesSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 04/12/24.
//

import SwiftUI

extension ProfileView {
    var favoriteGamesSection: some View {
        VStack(alignment: .leading) {
            Text(constants.title)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(viewModel.gamesDetails?.games.sorted(by: { $0.key < $1.key }) ?? [], id: \.key) { id, game in
                
                Button(action: {
                    router.present(fullScreenCover: .gameDetail(gameID: id, onDisappear: self.configure))
                }, label: {
                    FavoriteGameCell(image: game.info.thumb ?? "",
                                     name: game.info.title ?? "",
                                     price: game.deals.first?.price ?? "",
                                     savings: game.deals.first?.savings ?? "",
                                     originalPrice: game.deals.first?.retailPrice ?? "",
                                     notificationIsActive: viewModel.notificationStatus(for: id)) {
                        // TODO: - Notification Action
                        
                        viewModel.setNotification(to: !viewModel.notificationStatus(for: id), gameID: id)
                        
                        viewModel.fetchFavoriteGames { result in
                            switch result {
                            case .success(let success):
                                viewModel.favoriteGames.append(contentsOf: success)
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                    }
                })
            }
        }
    }
}

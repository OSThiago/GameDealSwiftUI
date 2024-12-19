//
//  FavoriteGamesSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 04/12/24.
//

import SwiftUI

extension ProfileView {
    var favoriteGamesSection: some View {
        VStack(alignment: .leading, spacing: Tokens.padding.xxxs) {
            if !viewModel.favoriteGames.isEmpty {
                favoriteTitle
                
                if !viewModel.onSaleGames.isEmpty {
                    onSaleList
                }
                
                if !viewModel.noDealsGames.isEmpty {
                    noDealsList
                }
                
            } else {
                EmptyState(title: "No Games",
                           description: "Add games to your favorite list",
                           icon: "gamecontroller.fill")
            }
        }
        .padding(.horizontal, Tokens.padding.xxxs)
    }
}

// MARK: - Title
extension ProfileView {
    var favoriteTitle: some View {
        Text(constants.favoriteTitle)
            .font(.title2)
            .fontWeight(.bold)
    }
}

// MARK: - On Sale List
extension ProfileView {
    var onSaleList: some View {
        VStack(alignment: .leading, spacing: Tokens.padding.nano) {
            Text(constants.onSale)
                .fontWeight(.semibold)
            favoriteList(games: viewModel.onSaleGames)
        }
    }
}

// MARK: - No Deals List
extension ProfileView {
    var noDealsList: some View {
        VStack(alignment: .leading, spacing: Tokens.padding.nano) {
            Text(constants.noDeals)
                .fontWeight(.semibold)
            favoriteList(games: viewModel.noDealsGames)
        }
    }
}

// MARK: - Games List component
extension ProfileView {
    func favoriteList(games: [String : GameLookup]) -> some View {
        ForEach(games.sorted(by: { $0.key < $1.key }), id: \.key) { id, game in
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

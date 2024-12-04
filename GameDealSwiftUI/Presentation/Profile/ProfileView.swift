//
//  ProfileView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var router: Router
    
    @StateObject var viewModel: ProfileViewModel
    
    let constants = ProfileConstants()
    
    init(viewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Text(constants.title)
                    .font(.title2)
                
                ForEach(viewModel.gamesDetails?.games.sorted(by: { $0.key < $1.key }) ?? [], id: \.key) { id, game in
                    
                    Button(action: {
                        router.present(fullScreenCover: .gameDetail(gameID: id))
                    }, label: {
                        FavoriteGameCell(image: game.info.thumb ?? "",
                                         name: game.info.title ?? "",
                                         price: game.deals.first?.price ?? "",
                                         savings: game.deals.first?.savings ?? "",
                                         originalPrice: game.deals.first?.retailPrice ?? "",
                                         notificationIsActive: .constant(false)) {
                            // TODO: - Notification Action
                            print("")
                        }
                    })
                }
            }
        }
        .padding(.horizontal, 16)
        .onAppear {
            viewModel.fetchFavoriteGames { result in
                switch result {
                case .success(let success):
                    viewModel.resetData()
                    viewModel.favoriteGames.append(contentsOf: success)
                    Task {
                        await viewModel.fetchGamesDetails()
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}

#Preview {
    ProfileConfigurator().configure()
}

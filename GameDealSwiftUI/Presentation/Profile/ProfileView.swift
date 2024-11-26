//
//  ProfileView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel
    
    let constants = ProfileConstants()
    
    init(viewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Text("Favorite Games")
            
            ForEach(viewModel.gamesDetails?.games.sorted(by: { $0.key < $1.key }) ?? [], id: \.key) { id, game in
                Text(game.info.title ?? "Error")
            }
        }
        .task {
            viewModel.fetchFavoriteGames { result in
                switch result {
                case .success(let success):
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

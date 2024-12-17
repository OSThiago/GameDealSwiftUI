//
//  ProfileView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @EnvironmentObject var router: Router
    
    @StateObject var viewModel: ProfileViewModel
    
    let constants = ProfileConstants()
    
    init(viewModel: ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                profileInfoSection
                    .padding(.bottom, 24)
                
                
                favoriteGamesSection
            }
            .padding(.bottom, 100)
        }
        .ignoresSafeArea()
        .toolbar(.hidden)
        .onAppear {
            configure()
        }
        .redacted(reason: viewModel.gamesDetails == nil ? .placeholder : [])
    }
    
    func configure() {
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

#Preview {
    ProfileConfigurator().configure()
}

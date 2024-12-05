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
            VStack {
                profileInfoSection
                    .padding(.bottom, 24)
                
                favoriteGamesSection
            }
        }
        .padding(.horizontal, 16)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            configure()
        }
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

extension ProfileView {
    var profileInfoSection: some View {
        VStack {
            Image(systemName: "person.fill")
                .frame(width: 150, height: 150)
                .scaleEffect(5)
                .background(Color.gray)
                .clipShape(.circle)
        }
    }
}

#Preview {
    ProfileConfigurator().configure()
}

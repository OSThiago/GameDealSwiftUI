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
            VStack(spacing: Tokens.padding.xxxs) {
                profileInfoSection

                favoriteGamesSection
            }
        }
        .onAppear {
            configure()
        }
        .redacted(reason: (viewModel.gamesDetails == nil && !viewModel.favoriteGames.isEmpty) ? .placeholder : [])
        .navigationTitle(constants.navigationTitle)
        .toolbarTitleDisplayMode(.inline)
        .toolbar { settingsButton }
        .sheet(item: $viewModel.activeSheet) { item in
            sheetView(item: item)
        }
    }
}

// MARK: - Life Cycle
extension ProfileView {
    func configure() {
        viewModel.configure()
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

// MARK: - Toolbar Settings Button
extension ProfileView {
    var settingsButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                router.push(.settings)
            } label: {
                Image(systemName: "gearshape")
                    .foregroundStyle(.gray)
            }
        }
    }
}

// MARK: - Sheet View
extension ProfileView {
    func sheetView(item: ProfileSheet) -> some View {
        switch item {
        case .profile:
            EditImageView(deletePhotoAction: {
                viewModel.removeProfileImage()
            },
                          pickerSelector: $viewModel.userImageSelection)
            .presentationDetents([.height(200)])
            .onDisappear {
                viewModel.activeSheet = nil
            }
        case .cover:
            EditImageView(deletePhotoAction: {
                viewModel.removeCoverImage()
            },
                          pickerSelector: $viewModel.coverImageSelection)
            .presentationDetents([.height(200)])
            .onDisappear {
                viewModel.activeSheet = nil
            }
        }
    }
}

#Preview {
    ProfileConfigurator().configure()
}

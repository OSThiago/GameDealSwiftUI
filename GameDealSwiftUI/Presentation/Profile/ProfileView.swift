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
        // MARK: - Body
        ZStack(alignment: .bottomLeading) {
            coverImage
            
            profileImage
                .padding(.bottom, -64)
                .padding(.leading, 16)
        }
        .padding(.bottom, 64)
    }
    
    // MARK: - Profile image
    @ViewBuilder
    private var profileImage: some View {
        
        let size: CGFloat = 100
        
        PhotosPicker(selection: $viewModel.userImageSelection, matching: .images) {
            if let image = viewModel.userImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: size, height: size)
                    .scaledToFit()
                    .background(Color.gray)
                    .clipShape(.circle)
            } else {
                Image(systemName: "person.fill")
                    .frame(width: size, height: size)
                    .scaleEffect(2)
                    .scaledToFit()
                    .background(Color.gray)
                    .clipShape(.circle)
            }
        }
    }
    
    // MARK: - Cover  image
    @ViewBuilder
    private var coverImage: some View {
        
        let width: CGFloat = ScreenSize.width
        let height: CGFloat = ScreenSize.width * 9/16
        
        PhotosPicker(selection: $viewModel.coverImageSelection, matching: .images) {
            if let image = viewModel.coverImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: width, height: height)
                    .scaledToFit()
            } else {
                Image(systemName: "photo.artframe")
                    .frame(width: width, height: height)
                    .scaleEffect(2)
                    .scaledToFit()
                    .background(Color.gray.opacity(0.4))
            }
        }
    }
}

#Preview {
    ProfileConfigurator().configure()
}

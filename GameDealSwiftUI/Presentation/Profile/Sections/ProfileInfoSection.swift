//
//  ProfileInfoSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 17/12/24.
//

import SwiftUI
import PhotosUI

extension ProfileView {
    var profileInfoSection: some View {
        // MARK: - Body
        ZStack(alignment: .center) {
            coverImage
                .padding(.horizontal, 16)
            
            VStack(spacing: 8) {
                
                Spacer()
                
                profileImage
                
                userInfoView
            }
            .padding(.bottom, -95)
        }
        .padding(.bottom, 64)
    }
    
    // MARK: - Profile image
    @ViewBuilder
    private var profileImage: some View {
        
        let size: CGFloat = 80
        
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
        
        let width: CGFloat = ScreenSize.width - 24
        let height: CGFloat = width * 9/18
        
        PhotosPicker(selection: $viewModel.coverImageSelection, matching: .images) {
            if let image = viewModel.coverImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: width, height: height)
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 12))
            } else {
                Image(systemName: "photo.artframe")
                    .frame(width: width, height: height)
                    .scaleEffect(2)
                    .scaledToFit()
                    .background(Color.gray.opacity(0.4))
                    .clipShape(.rect(cornerRadius: 12))
            }
        }
    }
    
    var userInfoView: some View {
        VStack(alignment: .center, spacing: 4) {
            TextField("User name", text: $viewModel.userName)
                .frame(width: 200, alignment: .center)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            HStack {
                Text("\(viewModel.gamesDetails?.games.count ?? 0)")
                    .fontWeight(.semibold)
                
                Text("Games")
                    .foregroundStyle(.gray)
                
                Text("•")
                
                Text("\(viewModel.onSaleGames.count)")
                    .fontWeight(.semibold)
                
                Text("Deals")
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    ProfileConfigurator().configure()
}

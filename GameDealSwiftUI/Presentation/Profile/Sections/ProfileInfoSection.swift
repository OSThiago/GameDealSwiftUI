//
//  ProfileInfoSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 17/12/24.
//

import SwiftUI
import PhotosUI

// MARK: - Body Section
extension ProfileView {
    var profileInfoSection: some View {
        ZStack(alignment: .center) {
            coverImage
                .padding(.horizontal, Tokens.padding.xxxs)
            
            VStack(spacing: Tokens.padding.nano) {
                
                Spacer()
                
                profileImage
                
                userInfoView
            }
            .padding(.bottom, -constants.profileBottomPadding)
        }
        .padding(.bottom, constants.profileBottomPadding)
    }
}

// MARK: - Profile image
extension ProfileView {
    @ViewBuilder
    private var profileImage: some View {
        
        let size = constants.profileImageSize
        
        PhotosPicker(selection: $viewModel.userImageSelection, matching: .images) {
            if let image = viewModel.userImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: size, height: size)
                    .scaledToFit()
                    .background(Color.gray)
                    .clipShape(.circle)
            } else {
                Image(systemName: constants.profilePlaceholderIcon)
                    .frame(width: size, height: size)
                    .scaleEffect(2)
                    .scaledToFit()
                    .background(Color.black)
                    .clipShape(.circle)
            }
        }
    }
}

// MARK: - Cover  image
extension ProfileView {
    @ViewBuilder
    private var coverImage: some View {
        
        let width = constants.coverWidth
        let height = constants.coverHeight
        
        PhotosPicker(selection: $viewModel.coverImageSelection, matching: .images) {
            if let image = viewModel.coverImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: width, height: height)
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: constants.coverRadius))
            } else {
                Image(systemName: constants.coverPlaceholderIcon)
                    .frame(width: width, height: height)
                    .scaleEffect(2)
                    .scaledToFit()
                    .background(Color.gray.opacity(0.4))
                    .clipShape(.rect(cornerRadius: constants.coverRadius))
            }
        }
    }
}

// MARK: - User Info
extension ProfileView {
    var userInfoView: some View {
        VStack(alignment: .center, spacing: Tokens.padding.quarck) {
            TextField(constants.userNamePlaceholder, text: $viewModel.userName)
                .frame(width: constants.userNameWidth, alignment: .center)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fontWeight(.semibold)
            
            HStack {
                Text("\(viewModel.gamesDetails?.games.count ?? 0)")
                    .fontWeight(.semibold)
                
                Text(constants.gamesCountTitle)
                    .foregroundStyle(.gray)
                
                Text(constants.userInfoSeparator)
                
                Text("\(viewModel.onSaleGames.count)")
                    .fontWeight(.semibold)
                
                Text(constants.dealsCountTitle)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    ProfileConfigurator().configure()
}

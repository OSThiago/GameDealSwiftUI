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
        ZStack(alignment: .bottomLeading) {
            coverImage
            
            HStack {
                profileImage
                
                VStack(alignment: .leading) {
                    
                    TextField("User name", text: $viewModel.userName) {
//                        Text("\($viewModel.userName)")
                    }
                    
                    HStack {
                        Text("\(viewModel.favoriteGames.count)")
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
                .padding(.top, 24)
            }
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

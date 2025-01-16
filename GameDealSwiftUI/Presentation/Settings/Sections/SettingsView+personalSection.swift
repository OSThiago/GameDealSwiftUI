//
//  SettingsView+personalSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 16/01/25.
//

import SwiftUI

extension SettingsView {
    var personalInformationSection: some View {
        Section {
            VStack {
                profileImage

                Text("\(viewModel.userName)")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text("\(viewModel.userEmail)")
                    .foregroundStyle(.gray)
            }
            .listRowBackground(Color(uiColor: .systemGray6))
            .frame(maxWidth: ScreenSize.width, alignment: .center)
        }
    }
    
    @ViewBuilder
    private var profileImage: some View {
        
        let size = constants.profileImageSize
        
        if let image = viewModel.userImage {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(image.size, contentMode: .fill)
                .frame(width: size, height: size)
                .background(Color.gray)
                .clipShape(.circle)
        } else {
            Image(systemName: constants.profilePlaceholderIcon)
                .frame(width: size, height: size)
                .scaleEffect(2)
                .scaledToFit()
                .background(Tokens.color.neutral.secondary)
                .clipShape(.circle)
        }
    }
}

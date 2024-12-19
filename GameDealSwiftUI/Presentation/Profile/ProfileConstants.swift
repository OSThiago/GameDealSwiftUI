//
//  ProfileConstants.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import Foundation

struct ProfileConstants {
    // Favorite Section
    let favoriteTitle = "Favorite Games"
    let onSale = "On Sale"
    let noDeals = "No Deals"
    let profileBottomPadding: CGFloat = 90
    // Profile Image
    let profileImageSize: CGFloat = 80
    let profilePlaceholderIcon = "person.fill"
    // Conver Image
    let coverWidth: CGFloat = ScreenSize.width - 24
    let coverHeight: CGFloat = (ScreenSize.width - 24) * 9/18
    let coverRadius: CGFloat = 12
    let coverPlaceholderIcon = "photo.artframe"
    // User Info
    let userNamePlaceholder = "User Name"
    let gamesCountTitle = "Games"
    let dealsCountTitle = "Deals"
    let userInfoSeparator = "•"
    let userNameWidth: CGFloat = 200
}

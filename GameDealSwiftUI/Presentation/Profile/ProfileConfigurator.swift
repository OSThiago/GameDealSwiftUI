//
//  ProfileConfigurator.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import Foundation

final class ProfileConfigurator {
    
    var viewModel: ProfileViewModel = ProfileViewModel()
    
    init() {}
    
    func configure() -> ProfileView {
        return ProfileView(viewModel: viewModel)
    }
}

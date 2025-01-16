//
//  SettingsConfigurator.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/01/25.
//

import Foundation

final class SettingsConfigurator {

    var viewModel: SettingsViewModel = SettingsViewModel()

    init () {}

    func configure() -> SettingsView {
        return SettingsView(viewModel: viewModel)
    }
}

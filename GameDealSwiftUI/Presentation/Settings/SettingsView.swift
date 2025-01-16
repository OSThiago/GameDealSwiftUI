//
//  SettingsView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/01/25.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    
    let constants = SettingsConstants()
    
    init(viewModel: SettingsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .task {
                viewModel.viewDidLoad()
            }
    }
}

// MARK: - Content
extension SettingsView {
    var content: some View {
        List {
            personalInformationSection
            itensSection
        }
    }
}

#Preview {
    SettingsConfigurator().configure()
}

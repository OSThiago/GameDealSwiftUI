//
//  SettingsView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/01/25.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    @Environment(\.colorScheme) var colorScheme
    
    let constants = SettingsConstants()
    
    init(viewModel: SettingsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
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
        .alert("title", isPresented: $viewModel.isShowingAlert) {
            TextField("", text: $viewModel.userNameAux)
            
            Button("Save", role: .none) {
                viewModel.saveUserNameAlert()
            }
            Button("Cancel", role: .cancel) {
                viewModel.cancelUserNameAlert()
            }
        }
        .alert("title", isPresented: $viewModel.isShowingEmailAlert) {
            TextField("", text: $viewModel.emailAux)
                .textInputAutocapitalization(.never)
            
            Button("Save", role: .none) {
                viewModel.saveEmailAlert()
            }
            Button("Cancel", role: .cancel) {
                viewModel.cancelEmailAlert()
            }
        }
    }
}

#Preview {
    SettingsConfigurator().configure()
}

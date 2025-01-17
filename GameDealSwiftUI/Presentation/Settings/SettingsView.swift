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
            .navigationTitle(constants.navigationTitle)
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
        .alert(constants.userNameTitle, isPresented: $viewModel.isShowingAlert) {
            TextField("", text: $viewModel.userNameAux)
            
            Button(constants.save, role: .none) {
                viewModel.saveUserNameAlert()
            }
            Button(constants.cancel, role: .cancel) {
                viewModel.cancelUserNameAlert()
            }
        }
        .alert(constants.emailTitle, isPresented: $viewModel.isShowingEmailAlert) {
            TextField("", text: $viewModel.emailAux)
                .textInputAutocapitalization(.never)
            
            Button(constants.save, role: .none) {
                viewModel.saveEmailAlert()
            }
            Button(constants.cancel, role: .cancel) {
                viewModel.cancelEmailAlert()
            }
        }
    }
}

#Preview {
    SettingsConfigurator().configure()
}

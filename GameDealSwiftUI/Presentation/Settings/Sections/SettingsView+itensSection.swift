//
//  SettingsView+itensSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/01/25.
//

import SwiftUI

extension SettingsView {
    var itensSection: some View {
        Section {
            userNameItem
            
            emailItem
            
            darkModeItem
            
            notificationItem
        } footer: {
            Text(constants.footerText)
        }
    }
    
    // MARK: - User Name
    private var userNameItem: some View {
        HStack {
            Text(constants.nameTitle)
            Spacer()
            Text("\(viewModel.userName)")
            Image(systemName: constants.iconChevron)
                .foregroundStyle(.gray)
        }
        .onTapGesture {
            viewModel.isShowingAlert = true
        }
    }
    
    // MARK: - E-mail
    private var emailItem: some View {
        HStack {
            Text(constants.emailTitle)
            Spacer()
            Text("\(viewModel.userEmail)")
            Image(systemName: constants.iconChevron)
                .foregroundStyle(.gray)
        }
        .onTapGesture {
            viewModel.isShowingEmailAlert = true
        }
    }
    
    // MARK: - Dark Mode
    private var darkModeItem: some View {
        HStack {
            Text(constants.darkModeTitle)
            Spacer()
            Toggle("", isOn: $viewModel.isActiveDarkMode)
        }
    }
    
    // MARK: - Notifications
    private var notificationItem: some View {
        HStack {
            Text(constants.notificationTitle)
                .foregroundStyle(.red)
            Spacer()
            Image(systemName: constants.iconChevron)
                .foregroundStyle(.gray)
        }
        .onTapGesture {
            
        }
    }
}

#Preview {
    SettingsConfigurator().configure()
}

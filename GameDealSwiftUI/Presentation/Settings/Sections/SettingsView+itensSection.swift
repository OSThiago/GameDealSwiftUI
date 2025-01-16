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
            Text("When you change your e-mail address, all notifications will be removed from the old e-mail address and you will need to manually add notifications to the new e-mail address.")
        }
    }
    
    // MARK: - User Name
    private var userNameItem: some View {
        HStack {
            Text("Name")
            Spacer()
            Text("\(viewModel.userName)")
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        .onTapGesture {
            viewModel.isShowingAlert = true
        }
    }
    
    // MARK: - E-mail
    private var emailItem: some View {
        HStack {
            Text("E-mail")
            Spacer()
            Text("\(viewModel.userEmail)")
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        .onTapGesture {
            viewModel.isShowingEmailAlert = true
        }
    }
    
    // MARK: - Dark Mode
    private var darkModeItem: some View {
        HStack {
            Text("Dark Mode")
            Spacer()
            Toggle("", isOn: $viewModel.isActiveDarkMode)
        }
    }
    
    // MARK: - Notifications
    private var notificationItem: some View {
        HStack {
            Text("Remove all notifications")
                .foregroundStyle(.red)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        .onTapGesture {
            
        }
    }
}

#Preview {
    SettingsConfigurator().configure()
}

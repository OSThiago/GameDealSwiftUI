//
//  SettingsViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/01/25.
//

import SwiftUI
import PhotosUI

enum SettingsAlerts {
    case userName, email, notification
}

final class SettingsViewModel: ObservableObject {
    
    // Dependency Injection
    @Injected private var userDefault: UserDefaultProtocol
    
    // MARK: - Data
    @Published private(set) var userImage: UIImage? = nil
    @Published var userName: String?
    @Published var userEmail: String?
    @Published var isActiveDarkMode = false
    @Published var userImageSelection: PhotosPickerItem? = nil {
        didSet {
            setUserImage(userImageSelection)
        }
    }
    // Alerts
    @Published var isShowingAlert = false
    @Published var activeAlert: SettingsAlerts? = nil
    
    // MARK: - Life Cyle
    func viewDidLoad() {
        loadUserDefaultsData()
    }
    
    // MARK: - Functions
    private func loadUserDefaultsData() {
        self.userName = userDefault.getUserName()
        self.userImage = userDefault.getImage(key: .userImage)
    }
    
    private func setUserImage(_ image: PhotosPickerItem?) {
        guard let image else { return }
        
        Task {
            if let data = try? await image.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                        self.userImage = uiImage
                        self.userDefault.saveImage(key: .userImage,
                                                   image: uiImage)
                }
            }
        }
    }
}

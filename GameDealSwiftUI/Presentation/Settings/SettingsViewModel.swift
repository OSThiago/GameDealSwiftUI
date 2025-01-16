//
//  SettingsViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/01/25.
//

import SwiftUI
import PhotosUI

final class SettingsViewModel: ObservableObject {
    
    // Dependency Injection
    @Injected private var userDefault: UserDefaultProtocol
    
    // MARK: - Data
    @Published private(set) var userImage: UIImage? = nil
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var isActiveDarkMode = false
    @Published var userImageSelection: PhotosPickerItem? = nil {
        didSet {
            setUserImage(userImageSelection)
        }
    }
    // Alerts
    @Published var isShowingAlert = false
    @Published var isShowingEmailAlert = false
    @Published var userNameAux = ""
    @Published var emailAux = ""
    
    // MARK: - Life Cyle
    func viewDidLoad() {
        loadUserDefaultsData()
        configureAlertAuxTexts()
    }
    
    // MARK: - Functions
    private func loadUserDefaultsData() {
        self.userName = userDefault.getUserName()
        self.userImage = userDefault.getImage(key: .userImage)
        self.userEmail = userDefault.getEmail()
    }
    
    private func configureAlertAuxTexts() {
        self.userNameAux = userName
        self.emailAux = userEmail
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
    
    // MARK: - Alerts functions
    // User Name
    func saveUserNameAlert() {
        userName = userNameAux
        userDefault.saveUserName(userName: userName)
    }
    func cancelUserNameAlert() {
        userNameAux = userName
    }
    
    // User E-mail
    func saveEmailAlert() {
        userEmail = emailAux
        userDefault.saveEmail(email: userEmail)
    }
    func cancelEmailAlert(){
        emailAux = userEmail
    }
}

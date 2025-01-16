//
//  UserDefaultImplementation.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 24/12/24.
//

import SwiftUI

final class UserDefaultImplementation: UserDefaultProtocol {
    
    private let userDefault = UserDefaults.standard
    
    
    // MARK: - User Image
    func saveImage(key: UserDefaultKeys, image: UIImage?) {
        if let image = image {
            guard let data = image.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(data)
            userDefault.set(encoded, forKey: key.rawValue)
        } else {
            userDefault.set(nil, forKey: key.rawValue)
        }
    }
    
    func getImage(key: UserDefaultKeys) -> UIImage? {
        guard let data = userDefault.object(forKey: key.rawValue) else { return nil }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data as! Data)
        let image = UIImage(data: decoded)
        return image
    }
    
    // MARK: - User Name
    func saveUserName(userName: String) {
        userDefault.set(userName, forKey: UserDefaultKeys.userName.rawValue)
    }

    func getUserName() -> String {
        return userDefault.string(forKey: UserDefaultKeys.userName.rawValue) ?? ""
    }
    
    // MARK: - Email
    func saveEmail(email: String) {
        userDefault.set(email, forKey: UserDefaultKeys.userEmail.rawValue)
    }
    
    func getEmail() -> String {
        return userDefault.string(forKey: UserDefaultKeys.userEmail.rawValue) ?? ""
    }
}

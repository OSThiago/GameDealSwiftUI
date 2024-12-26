//
//  UserDefaultProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 24/12/24.
//
import SwiftUI

enum UserDefaultKeys: String {
    case userImage
    case coverImage
    case userName
}

protocol UserDefaultProtocol {
    func saveImage(key: UserDefaultKeys, image: UIImage?)
    func saveUserName(userName: String)
    func getImage(key: UserDefaultKeys) -> UIImage?
    func getUserName() -> String
}

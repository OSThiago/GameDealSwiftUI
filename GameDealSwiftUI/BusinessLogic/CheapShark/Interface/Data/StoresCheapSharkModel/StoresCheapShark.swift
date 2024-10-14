//
//  StoresCheapShark.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import Foundation

struct StoresCheapShark: Codable {
    let storeID: String
    let storeName: String
    let isActive: Bool
    let images: StoreImagesCheapShark
}

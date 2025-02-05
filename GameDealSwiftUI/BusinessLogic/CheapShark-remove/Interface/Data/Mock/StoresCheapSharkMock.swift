//
//  StoresCheapSharkMock.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import Foundation

extension StoresCheapShark {
    static let steamMock: Self = .init(
        storeID: "1",
        storeName: "Steam",
        isActive: 1,
        images: StoreImagesCheapShark.steamMockImages)
}

extension StoreImagesCheapShark {
    static let steamMockImages: Self = .init(
        banner: "https://www.cheapshark.com/img/stores/banners/0.png",
        logo: "https://www.cheapshark.com/img/stores/logos/0.png",
        icon: "https://www.cheapshark.com/img/stores/icons/0.png")
}

//
//  DealLookupMock.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import Foundation

extension DealLookup {
    static let theWitcher2: Self = .init(
        storeID: "1",
        gameID: "5572",
        name: "The Witcher 2: Assassins of Kings Enhanced Edition",
        salePrice: "19.99",
        retailPrice: "19.99",
        thumb: "https://cdn.cloudflare.steamstatic.com/steam/apps/20920/capsule_sm_120.jpg?t=1659618473",
        cheaperStores: [.theWircher2],
        cheapestPrice: .theWitcher2, 
        metacriticLink: "/game/the-witcher-2-assassins-of-kings/")
}

extension CheaperStores {
    static let theWircher2: Self = .init(
        dealID: "wbwSwOEEf%2FXwtxjY8CVuiEfXM4NXhJq6i8wy%2FJbS5aY%3D",
        storeID: "7",
        salePrice: "2.99",
        retailPrice: "19.99")
}

extension CheapestPrice {
    static let theWitcher2: Self = .init(
        price: "2.49",
        date: 1524419835)
}

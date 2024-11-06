//
//  Untitled.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 01/10/24.
//

import Foundation

struct GameModel: Codable {
    let gameID: String?
    let steamAppID: String?
    let cheapest: String?
    let cheapestDealID: String?
    let external: String?
    let internalName: String?
    let thumb: String?
}


// MARK: - Mock
extension GameModel {
    static let witcher2Mock: Self = {
        return .init(gameID: "5572",
                     steamAppID: "20920",
                     cheapest: "2.99",
                     cheapestDealID: "8JWQ51DVapSJnGVviMI0Hgu4YFqxme2sBdLD3vh6dZw%3D",
                     external: "The Witcher 2: Assassins of Kings Enhanced Edition",
                     internalName: "THEWITCHER2ASSASSINSOFKINGSENHANCEDEDITION",
                     thumb: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/20920/capsule_sm_120.jpg?t=1729586898")
    }()
}

//
//  DealLookup.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import Foundation

struct DealLookup: Codable {
    let storeID: String
    let gameID: String
    let name: String
    let salePrice: String
    let retailPrice: String
    let thumb: String
    let cheaperStores: [CheaperStores]
    let cheapestPrice: CheapestPrice
    let metacriticLink: String
}

//
//  GameLookup.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 01/10/24.
//

import Foundation

struct GameLookup: Codable {
    let info: InfoGameLookupModel
    let cheapestPriceEver: CheapestPriceEver
    let deals: [DealsGameLookupModel]
}

struct InfoGameLookupModel: Codable {
    let title: String?
    let steamAppID: String?
    var thumb: String?
}

struct DealsGameLookupModel: Codable {
    let storeID: String?
    let dealID: String?
    let price: String?
    let retailPrice: String?
    let savings: String?
}

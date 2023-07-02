//
//  GameLookupModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 26/06/23.
//

import Foundation

struct GameLookupModel: Codable {
    let info: InfoGameLookupModel?
    let cheapestPriceEver: CheapestPrice?
    let deals: [DealsGameLookupModel]?
    
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

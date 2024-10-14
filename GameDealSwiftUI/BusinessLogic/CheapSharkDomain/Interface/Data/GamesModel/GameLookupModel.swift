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

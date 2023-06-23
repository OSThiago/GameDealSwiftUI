//
//  FeedGameDeal.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import Foundation

struct FeedGameDealModel: Codable, Hashable {
    let gameID: String
    let dealID: String
    let storeID: String
    let title: String
    let salePrice: String
    let normalPrice: String
    let savings: String
    let thumb: String
}

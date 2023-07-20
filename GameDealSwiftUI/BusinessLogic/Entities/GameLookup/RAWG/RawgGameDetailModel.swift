//
//  RawgGameDetailModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 10/07/23.
//

import Foundation

// Game detail from RAWG API
struct RwGameDetailModel: Codable {
    let id: Int?
    let slug: String?
    let name: String?
    let nameOriginal: String?
    let descriptionRaw: String?
    let released: String?
    let backgroundImage: String?
    let backgroundImageAdditional: String?
    let rating: Double?
    //let parentPlataforms: [RwParentPlataform]
    let genres: [RwGenre]?
    let tags: [RwTag]?
}

struct RwParentPlataform: Codable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct RwGenre: Codable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct RwTag: Codable {
    let id: Int?
    let name: String?
}

struct RwPublishers: Codable {
    let id: Int?
    let name: String?
    let slug: String?
}

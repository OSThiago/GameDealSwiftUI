//
//  MetacriticDetailModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/07/24.
//

import Foundation

struct MetacriticDetailModel {
    let description: String
    let releaseDate: String
    let publisher: String
    let platforms: [String]
    let developers: [String]
    let genres: [String]
}


extension MetacriticDetailModel {
    static let thewitcher3: Self =
        .init(description: "DESCRIPTION: With the Empire attacking the Kingdoms of the North and the Wild Hunt, a cavalcade of ghastly riders, breathing down your neck, the only way to survive is to fight back. As Geralt of Rivia, a master swordsman and monster hunter, leave none of your enemies standing. Explore a gigantic open world, slay beasts and decide the fates of whole communities with your actions, all in a genuine next generation format.",
              releaseDate: "May 19, 2015",
              publisher: "Warner Bros. Interactive Entertainment",
              platforms: ["PC", "Xbox One", " PlayStation 4", " Nintendo Switch"],
              developers: ["CD Projekt Red Studio"],
              genres: ["Action RPG"])
}

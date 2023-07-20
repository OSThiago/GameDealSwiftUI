//
//  RwGameDetailModelMock.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 10/07/23.
//

import Foundation

extension RwGameDetailModel {
    static let MortalKombatXL = Self .init(
        id: 2745,
        slug: "mortal-kombat-xl",
        name: "Mortal Kombat XL",
        nameOriginal: "Mortal Kombat XL",
        descriptionRaw: "One of the best-selling titles of 2015 has gone XL! Komplete The Mortal Kombat X Experience with new and existing content. Includes the main game, and new playable characters Alien, Leatherface, Triborg, and Bo’Rai Cho. Previously released playable characters include Predator, Jason Voorhees, Tremor, Tanya, and Goro. Also includes the new skins pack Apocalypse Pack and all previously released skins packs.\nUse of PSN and SEN account are subject to the Terms of Service and User Agreement and applicable privacy policy (see terms at sonyentertainmentnetwork.com/terms-of-service & sonyentertainmentnetwork.com/privacy-policy). *Online multiplayer also requires a PlayStation®Plus subscription.\n1-2 players\nNetwork Players 2-10\nDUALSHOCK®4\n1080p HD Video Output\nOnline Play (Optional)\nSoftware subject to license (us.playstation.com/softwarelicense).  Online activity subject to Terms of Services and User Agreement (www.playstationnetwork.com/terms-of-service). One-time license fee for play on account’s designated primary PS4™ system and other PS4™ systems when signed in with that account.\nMORTAL KOMBAT XL software © 2016 Warner Bros. Entertainment Inc. Developed by NetherRealm Studios. ALIEN and PREDATOR ™ & © 2016 Twentieth Century Fox Film Corporation. All rights reserved. JASON VOORHEES and all related elements are trademarks of and © New Line Productions, Inc.  The Texas Chainsaw Massacre © 1974 VORTEX, INC. /KIM HENKEL/TOBE HOOPER Leatherface™ and The Texas Chainsaw Massacre™ are trademarks of VORTEX, INC./KIM HENKEL/TOBE HOOPER. All Rights Reserved. All other trademarks and copyrights are the property of their respective owners.  All rights reserved.\nWB GAMES LOGO, WB SHIELD, NETHERREALM STUDIOS LOGO, MORTAL KOMBAT, THE DRAGON LOGO, and all related characters and elements are trademarks of and © Warner Bros. Entertainment Inc.\n(s16)",
        released: "2016-03-01",
        backgroundImage: "https://media.rawg.io/media/screenshots/601/601c3d179639c53e55531fa8efde6435.jpg",
        backgroundImageAdditional: "https://media.rawg.io/media/screenshots/6e9/6e97ff9246dcf17a70b5c02a138f85fd_cJork1j.jpg",
        rating: 4.15,
        //parentPlataforms: [.pc, .playStation],
        genres: [.fighting],
        tags: [.multiplayer, .online]
    )
}

extension RwParentPlataform {
    static let pc = Self .init(
        id: 1,
        name: "PC",
        slug: "pc"
    )
    
    static let playStation = Self.init(
        id: 2,
        name: "PlayStation",
        slug: "playstation"
    )
}

extension RwGenre {
    static let fighting = Self.init(
        id: 6,
        name: "Fighting",
        slug: "fighting"
    )
}

extension RwTag {
    static let multiplayer = Self.init(
        id: 7,
        name: "Multiplayer"
    )
    
    static let online = Self.init(
        id: 413,
        name: "online"
    )
}

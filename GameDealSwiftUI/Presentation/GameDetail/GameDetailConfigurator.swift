//
//  GameDetailConfigurator.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 08/11/24.
//

import Foundation

final class GameDetailConfigurator {
    
    private let gameId: String
    
    lazy var viewModel: GameDetailViewModel = {
        return .init(gameid: self.gameId)
    }()
    
    init(gameId: String) {
        self.gameId = gameId
    }
    
    func configure() -> GameDetailView {
        return .init(viewModel: viewModel)
    }
}

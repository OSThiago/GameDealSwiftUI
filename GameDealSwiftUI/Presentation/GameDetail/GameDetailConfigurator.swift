//
//  GameDetailConfigurator.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 08/11/24.
//

import Foundation

final class GameDetailConfigurator {
    
    private let gameId: String
    private let onDisappear: (() -> Void)?
    
    lazy var viewModel: GameDetailViewModel = {
        return .init(gameid: self.gameId)
    }()
    
    init(gameId: String, onDisappear: (() -> Void)?) {
        self.gameId = gameId
        self.onDisappear = onDisappear
    }
    
    func configure() -> GameDetailView {
        return .init(viewModel: viewModel,
                     onDisappear: onDisappear)
    }
}

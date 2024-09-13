//
//  FeedConfigurator.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/24.
//

import Foundation

final class FeedConfigurator {
    
    var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel = FeedViewModel()
    ) {
        self.viewModel = viewModel
    }
    
    func configure() -> FeedView {
        return .init(viewModel: self.viewModel)
    }
}

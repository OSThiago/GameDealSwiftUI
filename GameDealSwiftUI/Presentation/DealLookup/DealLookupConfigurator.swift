//
//  DealLookupConfigurator.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/24.
//

import Foundation

final class DealLookupConfigurator {
    
    let feedGameDealModel: FeedGameDealModel
    
    var viewModel: DealLookupViewModel
    
    init(feedGameDealModel: FeedGameDealModel,
         viewModel: DealLookupViewModel = .init()
    ) {
        self.feedGameDealModel = feedGameDealModel
        self.viewModel = viewModel
    }
    
    func configure() -> DealLookupView {
        return .init(feedGameDealModel: self.feedGameDealModel,
                     viewModel: self.viewModel)
    }
}

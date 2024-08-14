//
//  DealLookupConfigurator.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/24.
//

import Foundation

final class DealLookupConfigurator {
    
    let feedGameDealModel: FeedGameDealModel
    
    var viewModel: DealLookupViewModel = DealLookupViewModel()
    
    init(feedGameDealModel: FeedGameDealModel) {
        self.feedGameDealModel = feedGameDealModel
    }
    
    func configure() -> DealLookupView {
        return .init(feedGameDealModel: self.feedGameDealModel,
                     viewModel: self.viewModel)
    }
}

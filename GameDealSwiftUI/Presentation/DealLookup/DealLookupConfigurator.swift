//
//  DealLookupConfigurator.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/24.
//

import Foundation

final class DealLookupConfigurator {
    
    let feedGameDealModel: FeedGameDealModel
    let store: StoresCheapShark
    
    lazy var viewModel: DealLookupViewModel = {
        return .init(feedGameDealModel: self.feedGameDealModel,
                     store: store)
    }()
    
    init(feedGameDealModel: FeedGameDealModel,
         store: StoresCheapShark
    ) {
        self.feedGameDealModel = feedGameDealModel
        self.store = store
    }
    
    func configure() -> DealLookupView {
        return .init(viewModel: self.viewModel)
    }
}

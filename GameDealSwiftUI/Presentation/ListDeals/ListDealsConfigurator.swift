//
//  ListDealsConfigurator.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/24.
//

import Foundation

final class ListDealsConfigurator {
    
    let store: StoresCheapShark

    lazy var viewModel: ListDealViewModel = {
        ListDealViewModel(store: store)
    }()
    
    init(
        store: StoresCheapShark
    ) {
        self.store = store
    }
    
    func configure() -> ListDealsView {
        return .init(viewModel: self.viewModel)
    }
}

//
//  ListDealsConfigurator.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/24.
//

import Foundation

final class ListDealsConfigurator {
    
    let store: StoresCheapShark
    let storesInformations: [StoresCheapShark]
    var viewModel: ListDealViewModel = ListDealViewModel()
    
    init(
        store: StoresCheapShark,
        storesInformations: [StoresCheapShark]
    ) {
        self.store = store
        self.storesInformations = storesInformations
    }
    
    func configure() -> ListDealsView {
        return .init(store: self.store,
                     storesInformations: self.storesInformations, 
                     viewModel: self.viewModel)
    }
}

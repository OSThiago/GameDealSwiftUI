//
//  GameDetailView+StoresDealsSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 19/11/24.
//

import SwiftUI

extension GameDetailView {
    var storesDealsSection: some View {
        VStack {
            ForEach(viewModel.gameLookupModel?.deals ?? [], id: \.dealID) { deal in
                if let store = viewModel.getStore(storeID: deal.storeID ?? "") {
                    let storeImage = viewModel.formatterUseCase.getStoreImage(store: store)
                    LookupDealStoreCell(storeImage: storeImage,
                                        storeTitle: store.storeName,
                                        dealPrice: deal.price,
                                        isCheaper: viewModel.isCheaper(value: deal.price))
                }
            }
        }
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126", onDisappear: nil).configure()
}

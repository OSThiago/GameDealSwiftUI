//
//  StoreListSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 24/07/24.
//

import SwiftUI

extension FeedView {
    @ViewBuilder
    func storeList(title: String, stores: [StoresCheapShark]) -> some View {
        
        let rows = [
            GridItem(.fixed(constants.gridItemSize)),
            GridItem(.fixed(constants.gridItemSize)),
            GridItem(.fixed(constants.gridItemSize))
        ]
        
        VStack(alignment: .leading, spacing: Tokens.padding.quarck) {
            // Title
            Text(title)
                .font(.title2)
                .bold()
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: Tokens.padding.quarck) {
                    ForEach(stores, id: \.storeID) { store in
                        VStack(spacing: Tokens.padding.quarck) {
                            NavigationLink {
                                ListDealsView(store: store, storesInformations: self.viewModel.storesInformations)
                                    .navigationTitle(store.storeName)
                            } label: {
                                StoreCell(storeName: store.storeName, storeBanner: viewModel.getStoreImage(storeID: store.storeID))
                            }
                            
                            Divider()
                                .padding(.leading, Tokens.padding.xl)
                        }
                    }
                }
            }
        }
    }
}

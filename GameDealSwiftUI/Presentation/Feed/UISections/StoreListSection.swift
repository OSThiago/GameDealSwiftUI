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
            GridItem(.fixed(50)),
            GridItem(.fixed(50)),
            GridItem(.fixed(50))
        ]
        
        VStack(alignment: .leading, spacing: 5) {
            // Title
            Text(title)
                .font(.title2)
                .bold()
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 5) {
                    ForEach(stores, id: \.storeID) { store in
                        VStack {
                            NavigationLink {
                                ListDealsView(store: store, storesInformations: self.viewModel.storesInformations)
                                    .navigationTitle(store.storeName)
                            } label: {
                                StoreCell(storeName: store.storeName, storeBanner: viewModel.getStoreImage(storeID: store.storeID))
                            }

                            Divider()
                                .padding(.leading)
                        }
                    }
                }
            }
        }
    }
}

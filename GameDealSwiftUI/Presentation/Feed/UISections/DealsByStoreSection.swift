//
//  DealsByStoreSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 24/07/24.
//

import SwiftUI

extension FeedView {
    @ViewBuilder
    var dealsByStoreSection: some View {
        VStack(alignment: .leading, spacing: Tokens.padding.xxs) {
            ForEach(viewModel.storesDeals, id: \.store.storeID) { store in
                dealsByStores(deals: store.dealsList, store: store.store)
            }
        }
    }
}

// MARK: - Deals by store list
extension FeedView {
    @ViewBuilder
    func dealsByStores(deals: [FeedGameDealModel], store: StoresCheapShark) -> some View {
        VStack(alignment: .leading, spacing: Tokens.padding.nano) {
            HStack(spacing: Tokens.padding.quarck) {
                // Store Banner
                StoreImage(storeImage: viewModel.getStoreImage(storeID: store.storeID),
                           size: constants.dealsByStoresImageStoreSize)
                    .padding(.leading)
                
                // Title
                Text(store.storeName)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    router.push(.listDeal(store: store, storesInformations: self.viewModel.storesInformations))
                }, label: {
                    Text(constants.seeAllButton)
                        .foregroundStyle(Color.blue)
                })
                .padding(.trailing)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -Tokens.padding.nano) {
                    ForEach(deals, id: \.dealID) { deal in
                        
                        let dealFormatted = viewModel.setupDealCell(deal)

                        Button {
                            router.push(.dealDetail(feedGameDealModel: deal))
                        } label: {
                            MediumDealCell(title: dealFormatted.title, salePrice: dealFormatted.salePrice, normalPrice: dealFormatted.normalPrice, savings: dealFormatted.savings, thumb: dealFormatted.thumb, storeThumb: dealFormatted.storeID)
                                .padding(.leading)
                        }
                    }
                }
            }
        }
    }
}

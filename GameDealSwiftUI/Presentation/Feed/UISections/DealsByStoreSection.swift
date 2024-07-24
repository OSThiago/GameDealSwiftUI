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
        VStack(alignment: .leading, spacing: 24) {
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
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                // Store Banner
                storeImage(storeBanner: viewModel.getStoreImage(storeID: store.storeID))
                    .padding(.leading)
                
                // Title
                Text(store.storeName)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink {
                    ListDealsView(store: store, storesInformations: self.viewModel.storesInformations)
                        .navigationTitle(store.storeName)
                } label: {
                    Text("See All")
                        .foregroundStyle(Color.blue)
                }
                .padding(.trailing)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -8) {
                    ForEach(deals, id: \.dealID) { deal in
                        
                        let dealFormatted = viewModel.setupDealCell(deal)

                        NavigationLink {
                            DealLookupView(feedGameDealModel: deal)
                                .navigationBarTitleDisplayMode(.inline)
                                //.navigationTitle(dealFormatted.title)
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

// MARK: - Store Image
extension FeedView {
    @ViewBuilder
    func storeImage(storeBanner: String) -> some View {
        AsyncImage(url: URL(string: storeBanner)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .clipped()
                    
            case .failure(_):
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

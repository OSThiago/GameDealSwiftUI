//
//  FeedView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        buildedContent
            .onAppear {
                Task {
                    viewModel.fetchStores()
                }
            }
            .onAppear {
                viewModel.displayDealsAAA()
            }
    }
}

// MARK: - Builded Content
extension FeedView {
    @ViewBuilder
    var buildedContent: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
        case .loaded:
            content
        case .error:
            Text("Error")
        }
    }
}

// MARK: - Content
extension FeedView {
    @ViewBuilder
    var content: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    largeList(deals: viewModel.dealsAAA, title: "Best Deals")
                    
                    storeList(title: "Game Stores", stores: viewModel.storesInformations)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(viewModel.storesDeals, id: \.store.storeID) { store in
                            mediumList(deals: store.dealsList, store: store.store)
                        }
                    }
                }
            }
            .foregroundStyle(Color(uiColor: colorScheme == .light ? .darkText : .lightText))
            .navigationTitle("Feed")
        }
    }
}

// MARK: - LIST AAA GAMES
extension FeedView {
    @ViewBuilder
    func largeList(deals: [FeedGameDealModel], title: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            // Title
            Text(title)
                .font(.title2)
                .bold()
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -20) {
                    ForEach(deals, id: \.dealID) { deal in
                        
                        let dealFormatted = viewModel.setupDealCell(deal)
                        
                        NavigationLink {
                            DealLookupView(feedGameDealModel: deal)
                                .navigationBarTitleDisplayMode(.inline)
                                //.navigationTitle(dealFormatted.title)
                        } label: {
                            LargeDealCell(title: dealFormatted.title, salePrice: dealFormatted.salePrice, normalPrice: dealFormatted.normalPrice, savings: dealFormatted.savings, thumb: dealFormatted.thumb, storeThumb: dealFormatted.storeID)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - LIST GAMES BY STORES
extension FeedView {
    @ViewBuilder
    func mediumList(deals: [FeedGameDealModel], store: StoresCheapShark) -> some View {
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

// MARK: - STORE LIST
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

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

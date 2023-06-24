//
//  FeedView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()
    @State var aaaID: FeedGameDealModel?
    
    var body: some View {
        NavigationView {
            ScrollView {
                Divider()
                
                VStack(spacing: 16) {
                    makeLargeList(deals: viewModel.dealsAAA, title: "AAA Games")
                    
                    makeStoreList(title: "Game Stores", stores: viewModel.storesInformations)
                    
                    ForEach(viewModel.storesDeals, id: \.store.storeID) { store in
                        makeMediumList(deals: store.dealsList, title: store.store.storeName)
                    }
                }
            }
            .onAppear {
                Task {
                    viewModel.fetchStores()
                }
            }
            .navigationTitle("Feed")
        }
    }
    
    // MARK: - LIST AAA GAMES
    @ViewBuilder
    func makeLargeList(deals: [FeedGameDealModel], title: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            // Title
            Text(title)
                .font(.title2)
                .bold()
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -5) {
                    ForEach(deals, id: \.dealID) { deal in
                        
                        let dealFormatted = viewModel.setupDealCell(deal)
                        
                        LargeDealCell(title: dealFormatted.title, salePrice: dealFormatted.salePrice, normalPrice: dealFormatted.normalPrice, savings: dealFormatted.savings, thumb: dealFormatted.thumb, storeThumb: dealFormatted.storeID)
                            .scenePadding(.leading)
                    }
                }
            }
            
            Divider()
                .padding(.horizontal)
                .padding(.top, 8)
        }
        .onAppear {
            viewModel.displayDealsAAA()
        }
    }
    
    // MARK: - LIST GAMES LIST
    @ViewBuilder
    func makeMediumList(deals: [FeedGameDealModel], title: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            // Title
            Text(title)
                .font(.title2)
                .bold()
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -8) {
                    ForEach(deals, id: \.dealID) { deal in
                        
                        let dealFormatted = viewModel.setupDealCell(deal)
                        
                        MediumDealCell(title: dealFormatted.title, salePrice: dealFormatted.salePrice, normalPrice: dealFormatted.normalPrice, savings: dealFormatted.savings, thumb: dealFormatted.thumb, storeThumb: dealFormatted.storeID)
                            .scenePadding(.leading)
                    }
                }
            }
            
            Divider()
                .padding(.horizontal)
                .padding(.top, 16)
        }
    }
    
    // MARK: - STORE LIST
    @ViewBuilder
    func makeStoreList(title: String, stores: [StoresCheapShark]) -> some View {
        
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
                        VStack{
                            StoreCell(storeName: store.storeName, storeBanner: viewModel.getStoreImage(storeID: store.storeID))
                            Divider()
                                .padding(.leading)
                        }
                    }
                }
            }
            
            Divider()
                .padding(.horizontal)
                .padding(.top, 8)
        }
    }
}



struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

//
//  ListDealsView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 24/06/23.
//

import SwiftUI

struct ListDealsView: View {
    
    @StateObject var viewModel = ListDealViewModel()
    @State var isShowDatail = false
    
    let storesInformations: [StoresCheapShark]
    let store: StoresCheapShark
    
    init(store: StoresCheapShark, storesInformations: [StoresCheapShark]) {
        self.store = store
        self.storesInformations = storesInformations
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(viewModel.dealList, id: \.dealID) { deal in
                    
                    let formatted = viewModel.setupDealCell(deal)
                    
                    NavigationLink {
                        DealLookupView(gameID: formatted.gameID)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationTitle(formatted.title)
                    } label: {
                        ListDealCell(title: formatted.title, salePrice: formatted.salePrice, normalPrice: formatted.normalPrice, savings: formatted.savings, thumb: formatted.thumb, storeThumb: formatted.storeID)
                    }
                    Divider()
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            viewModel.store = store
            viewModel.storesInformations = storesInformations
            viewModel.fetchDeals()
        }
    }
}

struct ListDealsView_Previews: PreviewProvider {
    static var previews: some View {
        ListDealsView(store: StoresCheapShark.steamMock, storesInformations: [])
    }
}

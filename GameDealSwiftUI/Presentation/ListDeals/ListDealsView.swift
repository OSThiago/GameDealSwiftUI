//
//  ListDealsView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 24/06/23.
//

import SwiftUI

struct ListDealsView: View {
    
    @StateObject var viewModel = ListDealViewModel()
    
    let store: StoresCheapShark
    let feedviewModel: FeedViewModel
    
    init(store: StoresCheapShark, feedviewModel: FeedViewModel) {
        self.store = store
        self.feedviewModel = feedviewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(viewModel.dealList, id: \.dealID) { deal in
                        // TODO: - formater dados
                        let formatted = feedviewModel.setupDealCell(deal)
                        
                        ListDealCell(title: formatted.title, salePrice: formatted.salePrice, normalPrice: formatted.normalPrice, savings: formatted.savings, thumb: formatted.thumb, storeThumb: formatted.storeID)
                        Divider()
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.store = store
            viewModel.fetchDeals()
        }
    }
}

struct ListDealsView_Previews: PreviewProvider {
    static var previews: some View {
        ListDealsView(store: StoresCheapShark.steamMock, feedviewModel: FeedViewModel())
    }
}

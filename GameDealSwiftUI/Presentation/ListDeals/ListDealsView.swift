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
    private let constants = ListDealConstants()
    
    let storesInformations: [StoresCheapShark]
    let store: StoresCheapShark
    
    init(store: StoresCheapShark, storesInformations: [StoresCheapShark]) {
        self.store = store
        self.storesInformations = storesInformations
    }
    
    var body: some View {
        buildedContent
        .onAppear {
            viewModel.store = store
            viewModel.storesInformations = storesInformations
            viewModel.fetchDeals()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                let image = viewModel.getStoreImage(storeID: store.storeID)
                StoreImage(storeImage: image, size: constants.storeImageSize)
            }
        }
    }
}

extension ListDealsView {
    @ViewBuilder
    var buildedContent: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
        case .loaded:
            content
        case .error:
            Text(constants.viewErrorState)
        }
    }
}

extension ListDealsView {
    @ViewBuilder
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: Tokens.padding.nano) {
                ForEach(viewModel.dealList, id: \.dealID) { deal in
                    
                    let formatted = viewModel.setupDealCell(deal)
                    
                    NavigationLink {
                        DealLookupView(feedGameDealModel: deal)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        ListDealCell(title: formatted.title,
                                     salePrice: formatted.salePrice,
                                     normalPrice: formatted.normalPrice,
                                     savings: formatted.savings,
                                     thumb: formatted.thumb,
                                     storeThumb: formatted.storeID)
                    }
                    Divider()
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ListDealsView_Previews: PreviewProvider {
    static var previews: some View {
        ListDealsView(store: StoresCheapShark.steamMock, storesInformations: [])
    }
}

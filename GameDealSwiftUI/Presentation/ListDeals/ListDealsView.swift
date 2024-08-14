//
//  ListDealsView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 24/06/23.
//

import SwiftUI

struct ListDealsView: View {
    
    @StateObject var viewModel: ListDealViewModel
    @EnvironmentObject var router: Router
    @State var isShowDatail = false
    private let constants = ListDealConstants()
    
    let storesInformations: [StoresCheapShark]
    let store: StoresCheapShark
    
    init(
        store: StoresCheapShark, 
        storesInformations: [StoresCheapShark],
        viewModel: ListDealViewModel
    ) {
        self.store = store
        self.storesInformations = storesInformations
        self._viewModel = StateObject(wrappedValue: viewModel)
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

// MARK: - Builded content
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

// MARK: - Content
extension ListDealsView {
    @ViewBuilder
    var content: some View {
        if !viewModel.dealList.isEmpty {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: Tokens.padding.nano) {
                    ForEach(viewModel.dealList, id: \.dealID) { deal in
                        
                        let formatted = viewModel.setupDealCell(deal)
                        
                        Button {
                            router.push(.dealDetail(feedGameDealModel: deal))
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
        } else {
            Text(constants.emptyMessage)
        }
    }
}

//struct ListDealsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListDealsView(store: StoresCheapShark.steamMock, storesInformations: [])
//    }
//}

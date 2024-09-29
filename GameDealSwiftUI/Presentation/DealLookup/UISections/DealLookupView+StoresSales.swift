//
//  DealLookupView+othersSales.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 06/08/24.
//

import SwiftUI

extension DealLookupView {
    @ViewBuilder
    var storesDealsSection: some View {
        
        let rows = [
            GridItem(.fixed(50)),
            GridItem(.fixed(50)),
            GridItem(.fixed(50))
        ]
        
        if viewModel.gameLookupModel?.deals?.count ?? 0  > 1 {
            VStack(alignment: .leading, spacing: 0) {
                Text("Others Stores")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, spacing: 0) {
                        ForEach(viewModel.gameLookupModel?.deals ?? [], id: \.dealID) { deal in
                            VStack {
                                if let store = viewModel.getStore(storeID: deal.storeID ?? "") {
                                    let storeImage = viewModel.FormatterUseCase.getStoreImage(store: store)
                                    LookupDealStoreCell(storeImage: storeImage,
                                                        storeTitle: store.storeName,
                                                        dealPrice: deal.price,
                                                        isCheaper: viewModel.isCheaper(chepeast: viewModel.feedGameDealModel.salePrice,
                                                                                       value: deal.price))
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
}

struct StoresDealsSection_Previews: PreviewProvider {
    static var previews: some View {
//        lazy var viewModel: DealLookupViewModel = {
//            let viewModel = DealLookupViewModel(feedGameDealModel: <#FeedGameDealModel#>, store: <#StoresCheapShark#>)
//            viewModel.viewState = .loaded
//            return viewModel
//        }()
//        
        DealLookupConfigurator(feedGameDealModel: FeedGameDealModel.riseOfIndustryMock,
                               store: .steamMock).configure()
    }
}

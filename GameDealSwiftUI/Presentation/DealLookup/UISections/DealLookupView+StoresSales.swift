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

                                let storeInformation = viewModel.getStore(id: deal.storeID ?? "0")
                                
                                let storeImage = viewModel.getStoreImage(storeID: storeInformation?.storeID ?? "0")
                                
                                LookupDealStoreCell(storeImage: storeImage, storeTitle: storeInformation?.storeName, dealPrice: deal.price)

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

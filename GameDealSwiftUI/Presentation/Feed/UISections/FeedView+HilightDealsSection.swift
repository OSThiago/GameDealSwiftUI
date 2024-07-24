//
//  FeedView+HilightDealsSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 23/07/24.
//

import SwiftUI

extension FeedView {
    @ViewBuilder
    func highlightDealSection(deals: [FeedGameDealModel], title: String) -> some View {
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

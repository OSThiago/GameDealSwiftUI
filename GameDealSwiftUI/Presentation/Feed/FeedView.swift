//
//  FeedView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        VStack {
            makeAAAList(deals: viewModel.dealsAAA)
        }
        .onAppear {
            viewModel.fetchStores()
        }
    }
    
    // MARK: - LIST AAA GAMES
    @ViewBuilder
    func makeAAAList(deals: [FeedGameDealModel]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(deals, id: \.dealID) { deal in
                    
                    let dealFormatted = viewModel.setupModel(deal)
                    
                    LargeDealCell(title: dealFormatted.title, salePrice: dealFormatted.salePrice, normalPrice: dealFormatted.normalPrice, savings: dealFormatted.savings, thumb: dealFormatted.thumb, storeThumb: dealFormatted.storeID)
                        .padding(.leading)
                }
            }
        }
        .onAppear {
            viewModel.displayDeaslAAA()
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

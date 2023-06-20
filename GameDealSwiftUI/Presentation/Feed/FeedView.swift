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
    }
    
    // MARK: - LIST AAA GAMES
    @ViewBuilder
    func makeAAAList(deals: [FeedGameDealModel]) -> some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(deals, id: \.dealID) { deal in
                    LargeDealCell(title: deal.title, salePrice: deal.salePrice, normalPrice: deal.normalPrice, savings: deal.savings, thumb: deal.thumb, storeThumb: "")
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

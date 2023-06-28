//
//  DealLookupView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 27/06/23.
//

import SwiftUI

struct DealLookupView: View {
    
    @StateObject var viewModel = DealLookupViewModel()
    
    private let gameID: String
    
    init(gameID: String) {
        self.gameID = gameID
    }
    
    var body: some View {
        VStack {
            Text(viewModel.gameLookupModel?.info?.title ?? "Error")
            
            ForEach(viewModel.gameLookupModel?.deals ?? [], id: \.dealID) { deal in
                
                HStack {
                    Text(deal.price ?? "No title")
                    Text(deal.retailPrice ?? "no Retail Price")
                    Spacer()
                    Text(deal.storeID ?? "no StoreID")
                }
                
            }
        }
        .onAppear {
            viewModel.fetchDealLookup(gameID: gameID)
        }
    }
    
    @ViewBuilder
    func gameImage() -> some View {
        
    }
}

struct DealLookupView_Previews: PreviewProvider {
    static var previews: some View {
        DealLookupView(gameID: FeedGameDealModel.riseOfIndustryMock.gameID)
    }
}

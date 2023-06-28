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
            Text(viewModel.gameLookupModel?.info.title ?? "Error")
        }
        .onAppear {
            viewModel.fetchDealLookup(gameID: gameID)
        }
    }
}

struct DealLookupView_Previews: PreviewProvider {
    static var previews: some View {
        DealLookupView(gameID: FeedGameDealModel.riseOfIndustryMock.gameID)
    }
}

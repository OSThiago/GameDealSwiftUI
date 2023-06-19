//
//  FeedView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()
    
    var factory: FeedViewFactory = FeedViewFactory()
    
    var body: some View {
        VStack {
            factory.makeAAAList(deals: viewModel.dealsAAA)
        }
        .onAppear {
            viewModel.displayDeaslAAA()
        }
    }
}

struct FeedViewFactory {
    
    @ViewBuilder
    func makeAAAList(deals: [FeedGameDealModel]) -> some View {
        List(deals, id: \.dealID) { deal in
            Text(deal.title)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

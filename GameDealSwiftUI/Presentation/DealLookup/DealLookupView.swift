//
//  DealLookupView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 27/06/23.
//

import SwiftUI

struct DealLookupView: View {
    
    @StateObject var viewModel = DealLookupViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    private let gameID: String
    
    init(gameID: String) {
        self.gameID = gameID
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                gameImage()
                    .ignoresSafeArea()
                
                Spacer()
                
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
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    dismiss()
//                } label: {
//                    Image(systemName: "chevron.left.circle.fill")
//                        .tint(.gray)
//                }
//            }
//        }
    }
    
    @ViewBuilder
    func gameImage() -> some View {
        AsyncImage(url: URL(string: viewModel.getHightQualityImage(url: viewModel.gameLookupModel?.info?.thumb ?? ""))) { phase in
            switch phase  {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: ScreenSize.width, height: ScreenSize.hight * 0.25)
                    .clipped()
                    
            case .failure(_):
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct DealLookupView_Previews: PreviewProvider {
    static var previews: some View {
        DealLookupView(gameID: FeedGameDealModel.riseOfIndustryMock.gameID)
    }
}

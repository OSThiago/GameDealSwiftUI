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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                makeGameImage()
                    .ignoresSafeArea()
                
                Spacer()
                
                makeGameTitle()
                    .padding(.horizontal)
                
                Divider()
                
                makeStoresDeals()
                
            }
            .onAppear {
                viewModel.fetchStoresInformations()
                viewModel.fetchDealLookup(gameID: gameID)
            }
        }
    }
    
    @ViewBuilder
    func makeGameImage() -> some View {
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
    
    @ViewBuilder
    func makeGameTitle() -> some View {
        Text(viewModel.gameLookupModel?.info?.title ?? "Error")
            .font(.title)
    }
    
    @ViewBuilder
    func makeStoresDeals() -> some View {
        
        let rows = [
            GridItem(.fixed(50)),
            GridItem(.fixed(50)),
            GridItem(.fixed(50))
        ]
        
        VStack(alignment: .leading) {
            Text("Others Stores")
                .font(.title2)
                .bold()
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 5) {
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
            
//            Divider()
//                .padding(.horizontal)
//                .padding(.top, 8)
        }
    }
}

struct DealLookupView_Previews: PreviewProvider {
    static var previews: some View {
        DealLookupView(gameID: FeedGameDealModel.riseOfIndustryMock.gameID)
    }
}

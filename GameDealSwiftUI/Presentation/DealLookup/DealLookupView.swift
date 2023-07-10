//
//  DealLookupView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 27/06/23.
//

import SwiftUI

struct DealLookupView: View {
    
    @StateObject var viewModel = DealLookupViewModel()
    
    private let feedGameDealModel: FeedGameDealModel
    
    init(feedGameDealModel: FeedGameDealModel) {
        self.feedGameDealModel = feedGameDealModel
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                makeGameImage()
                    .ignoresSafeArea()
                
                Spacer()
                
//                makeGameTitle()
//                    .padding(.horizontal)
                
                //Divider()
                
                makeDealDetail()
                
                Divider()
                
                makeStoresDeals()
                
            }
            .onAppear {
                viewModel.fetchStoresInformations()
                viewModel.feedGameDealModel = feedGameDealModel
                viewModel.fetchDealLookup(gameID: feedGameDealModel.gameID)
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
    func makeCurrentStoreImage() -> some View {
        AsyncImage(url: URL(string: viewModel.getStoreImage(storeID: feedGameDealModel.storeID))) { phase in
            switch phase  {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
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
    func makeDealDetail() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                makeGameTitle()
                
                Spacer()
                
                HStack {
                    
                
                    Text(feedGameDealModel.salePrice)

                    Text(feedGameDealModel.normalPrice)
                
                    Text(feedGameDealModel.savings)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                makeCurrentStoreImage()
                Text(viewModel.getStore(id: feedGameDealModel.storeID)?.storeName ?? "Unkwon")
                    .font(.headline)
                
                Spacer()
                
                makeBuyButton(dealID: "game id")
            }
        }
        .padding(.horizontal)
    }

    
    @ViewBuilder
    func makeBuyButton(dealID: String) -> some View {
        Button {
            print("Buy - \(dealID)")
        } label: {
            Text("Buy")
        }
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
        }
    }
}

struct DealLookupView_Previews: PreviewProvider {
    static var previews: some View {
        DealLookupView(feedGameDealModel: FeedGameDealModel.riseOfIndustryMock)
    }
}

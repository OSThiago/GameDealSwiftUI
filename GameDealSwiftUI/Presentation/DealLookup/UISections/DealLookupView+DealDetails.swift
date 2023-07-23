//
//  DealLookupView+DealDetails.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 20/07/23.
//

import SwiftUI

extension DealLookupView {
    
    @ViewBuilder
    func makeSectionDeailDetail() -> some View {
        VStack(alignment: .leading) {
            makeGameImage()
            
            Spacer()
            
            makeDealDetail()
            
            Divider()
            
            makeStoresDeals()
        }
    }
    
    @ViewBuilder
    private func makeGameImage() -> some View {
        GeometryReader { reader in
            AsyncImage(url: URL(string: viewModel.getHightQualityImage(url: viewModel.gameLookupModel?.info?.thumb ?? ""))) { phase in
                switch phase  {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: ScreenSize.width, height: abs(reader.frame(in: .global).minY + ScreenSize.hight * 0.35))
                        .clipped()
                        .offset(y: -reader.frame(in: .global).minY < abs(reader.frame(in: .global).minY + ScreenSize.hight * 0.35) ? -reader.frame(in: .global).minY : 0)
                        
                case .failure(_):
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
        }
        // Default frame
        .frame(height: ScreenSize.hight * 0.35)
    }
    
    @ViewBuilder
    private func makeCurrentStoreImage() -> some View {
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
    private func makeGameTitle() -> some View {
        Text(viewModel.gameLookupModel?.info?.title ?? "Error")
            .font(.title)
    }
    
    @ViewBuilder
    private func makeDealDetail() -> some View {
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
    private func makeBuyButton(dealID: String) -> some View {
        Button {
            print("Buy - \(dealID)")
        } label: {
            Text("Buy")
        }
    }
    
    @ViewBuilder
    private func makeStoresDeals() -> some View {
        
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

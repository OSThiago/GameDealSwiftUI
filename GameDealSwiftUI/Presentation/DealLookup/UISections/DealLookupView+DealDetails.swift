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
        
        let imageHeight = 220.0
        
            AsyncImage(url: URL(string: viewModel.getHightQualityImage(url: viewModel.gameLookupModel?.info?.thumb ?? ""))) { phase in
                switch phase  {
                case .empty:
                    ProgressView()
                case .success(let image):
                    GeometryReader { reader in
                        
                        let offsetY = reader.frame(in: .global).minY
                        let isScrolled = offsetY > 0
                        
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: ScreenSize.width, height: isScrolled ? offsetY + imageHeight : imageHeight)
                            .clipped()
                            .offset(y: isScrolled ? -offsetY : 0)
                            .scaleEffect(isScrolled ? offsetY / 2000 + 1 : 1)
                    }
                    // Default frame
                    .frame(height: imageHeight)
                        
                case .failure(_):
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
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
        VStack(alignment: .leading) {
            Text("Stores")
                .font(.title2)
                .bold()
                .padding(.leading)
            
            VStack(alignment: .leading) {
                ForEach(viewModel.gameLookupModel?.deals ?? [], id: \.dealID) { deal in
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

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
            gameImage()
            
            Spacer()
            
            dealDetail()
            
            Divider()
            
            storesDeals()
        }
    }
    
    @ViewBuilder
    func gameImage() -> some View {
        
        let url = viewModel.getHightQualityImage(url: viewModel.gameLookupModel?.info?.thumb ?? "")
        
        let imageHeight = 220.0
        
        AsyncImage(url: URL(string: url)) { phase in
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
//                        .aspectRatio(contentMode: .fill)
                        .frame(width: ScreenSize.width, height: isScrolled ? offsetY + imageHeight : imageHeight)
//                        .frame(width: ScreenSize.width, height: imageHeight, alignment: .top)
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
    func currentStoreImage() -> some View {
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
            .fontWeight(.medium)
    }
    
    @ViewBuilder
    func dealDetail() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            makeGameTitle()
                .padding(.bottom, 16)
            
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text("$\(feedGameDealModel.salePrice)")
                        .font(.body)
                        .fontWeight(.medium)
                    
                    Text("$\(feedGameDealModel.normalPrice)")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .strikethrough()
                        .foregroundStyle(Color.gray)
                    
                    Spacer()
                    
                    Text(viewModel.formatSavings(feedGameDealModel.savings))
                        .font(.body)
                        .fontWeight(.bold)
                }
            }

            HStack(alignment: .center) {
                currentStoreImage()
                
                Text(viewModel.getStore(id: feedGameDealModel.storeID)?.storeName ?? "Unkwon")
                    .font(.body)
                    .fontWeight(.bold)
                
                Spacer()
                
                makeBuyButton(dealID: "game id")
            }
            
            Divider()
                .padding(.bottom, 8)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }

    @ViewBuilder
    func makeBuyButton(dealID: String) -> some View {
        Button {
            print("Buy - \(dealID)")
        } label: {
            Text("Buy")
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .frame(width: 65, height: 25)
        }
        .background(Color.blue)
        .clipShape(.rect(cornerRadius: 12))
    }
    
    @ViewBuilder
    func storesDeals() -> some View {
        
        let rows = [
            GridItem(.fixed(50)),
            GridItem(.fixed(50)),
            GridItem(.fixed(50))
        ]
        
        if viewModel.gameLookupModel?.deals?.count ?? 0  > 1 {
            VStack(alignment: .leading, spacing: 0) {
                Text("Others Stores")
                    .font(.body)
                    .fontWeight(.bold)
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
}

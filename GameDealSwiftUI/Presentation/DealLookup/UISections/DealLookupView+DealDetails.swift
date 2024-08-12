//
//  DealLookupView+DealDetails.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 20/07/23.
//

import SwiftUI
 
// MARK: - Game Image
extension DealLookupView {
    @ViewBuilder
    var gameImage: some View {
        
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
}

// MARK: - Deal Detail Section
extension DealLookupView {
    @ViewBuilder
    var dealDetailSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    gameTitle
                                    
                    storeName
                }
                
                Spacer()
                
                StoreImage(storeImage: viewModel.getStoreImage(storeID: feedGameDealModel.storeID),
                           size: 40)
            }
            .padding(.bottom, 32)

            
            HStack(alignment: .bottom) {
//                Savings(savings: viewModel.formatSavings(feedGameDealModel.savings),
//                        font: .body,
//                        padding: 8)
                
                salePrice

                normalPrice
                                                
                Spacer()
                
                buyButton(dealID: "game id")
            }
            
            Divider()
                .padding(.top, 8)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

// MARK: - Game Title
extension DealLookupView {
    @ViewBuilder
    var gameTitle: some View {
        Text(viewModel.gameLookupModel?.info?.title ?? "Error")
            .font(.title2)
            .fontWeight(.semibold)
    }
}

// MARK: - Sale Price
extension DealLookupView {
    @ViewBuilder
    var salePrice: some View {
        Text("$\(feedGameDealModel.salePrice)")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(Tokens.color.positive.secondary)
    }
}

// MARK: - Normal Price
extension DealLookupView {
    @ViewBuilder
    var normalPrice: some View {
        Text("$\(feedGameDealModel.normalPrice)")
            .font(.subheadline)
            .fontWeight(.regular)
            .strikethrough()
            .foregroundStyle(Tokens.color.neutral.primary)
    }
}

// MARK: - Store Name
extension DealLookupView {
    var storeName: some View {
        Text(viewModel.getStore(id: feedGameDealModel.storeID)?.storeName ?? "Unkwon")
            .font(.body)
            .fontWeight(.medium)
            .foregroundStyle(Tokens.color.neutral.primary)
    }
}

// MARK: - Buy Button
extension DealLookupView {
    @ViewBuilder
    func buyButton(dealID: String) -> some View {
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
}

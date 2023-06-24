//
//  LargeDealCell.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

struct LargeDealCell: View {
    
    let title: String
    let salePrice: String
    let normalPrice: String
    let savings: String
    var thumb: String
    let storeThumb: String
    
    private let cellWidth = ScreenSize.width * 0.9
    
    var body: some View {
        VStack {
            // Thumb
            gameImage()
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    gameTitleText()
                    
                    Spacer()
                    
                    storeImage()
                }
                
                HStack(alignment: .top) {
                    salePriceText()
                    
                    normalPriceText()
                    
                    Spacer()
                    
                    savingsText()
                }
            }
            //Divider()
        }
        .frame(maxWidth: cellWidth)
    }
    
    // MARK: - Game Title
    @ViewBuilder
    func gameTitleText() -> some View {
        Text(title)
            .font(.title2)
    }
    
    // MARK: - Sale price
    @ViewBuilder
    func salePriceText() -> some View {
        Text(salePrice)
            .font(.subheadline)
            .bold()
    }
    
    // MARK: - Normal Price
    @ViewBuilder
    func normalPriceText() -> some View {
        Text(normalPrice)
            .font(.subheadline)
            .strikethrough()
    }
    
    // MARK: - Savings
    @ViewBuilder
    func savingsText() -> some View {
        Text(savings)
            .font(.subheadline)
            .bold()
    }
    
    // MARK: - Game Image
    @ViewBuilder
    func gameImage() -> some View {
        AsyncImage(url: URL(string: thumb)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: cellWidth, height: 200)
                    .clipped()
                    .cornerRadius(3)
                    
            case .failure(_):
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
    
    // MARK: - Store Image
    @ViewBuilder
    func storeImage() -> some View {
        AsyncImage(url: URL(string: storeThumb)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 31, height: 31)
                    .clipped()
                    
            case .failure(_):
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct LargeDealCell_Previews: PreviewProvider {
    static var previews: some View {
        let mock = FeedGameDealModel.riseOfIndustryMock
        let storeMock = StoreImagesCheapShark.steamMockImages.icon
        
        LargeDealCell(title: mock.title, salePrice: mock.salePrice, normalPrice: mock.normalPrice, savings: mock.savings, thumb: mock.thumb, storeThumb: storeMock)
    }
}

//
//  MediumDealCell.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 23/06/23.
//

import SwiftUI

struct MediumDealCell: View {
    let title: String
    let salePrice: String
    let normalPrice: String
    let savings: String
    var thumb: String
    let storeThumb: String
    
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
        }
        .frame(maxWidth: 157)
    }
    
    // MARK: - Game Title
    @ViewBuilder
    func gameTitleText() -> some View {
        Text(title)
            .font(.title3)
    }
    
    // MARK: - Sale price
    @ViewBuilder
    func salePriceText() -> some View {
        Text(salePrice)
            .font(.caption2)
            .bold()
    }
    
    // MARK: - Normal Price
    @ViewBuilder
    func normalPriceText() -> some View {
        Text(normalPrice)
            .font(.caption2)
            .strikethrough()
    }
    
    // MARK: - Savings
    @ViewBuilder
    func savingsText() -> some View {
        Text(savings)
            .font(.caption2)
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
                    .frame(width: 157, height: 100)
                    .clipped()
                    
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
                    .frame(width: 16, height: 16)
                    .clipped()
                    
            case .failure(_):
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct MediumDealCell_Previews: PreviewProvider {
    static var previews: some View {
        MediumDealCell(title: FeedGameDealModel.riseOfIndustryMock.title, salePrice: FeedGameDealModel.riseOfIndustryMock.salePrice, normalPrice: FeedGameDealModel.riseOfIndustryMock.normalPrice, savings: FeedGameDealModel.riseOfIndustryMock.savings, thumb: FeedGameDealModel.riseOfIndustryMock.thumb, storeThumb: FeedGameDealModel.riseOfIndustryMock.storeID)
    }
}

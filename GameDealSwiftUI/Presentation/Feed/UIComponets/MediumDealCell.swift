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
            ZStack(alignment: .bottomLeading) {
                // Thumb
                gameImage()
                
                gameTitleText()
                    .padding(8)
            }
            
           
            HStack(alignment: .bottom, spacing: 2) {
                salePriceText()
                
                normalPriceText()
                
                Spacer()
                
                savingsText()
            }
            
        }
        .frame(maxWidth: 170)
    }
    
    // MARK: - Game Title
    @ViewBuilder
    func gameTitleText() -> some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .multilineTextAlignment(.leading)
    }
    
    // MARK: - Sale price
    @ViewBuilder
    func salePriceText() -> some View {
        Text(salePrice)
            .font(.body)
            .fontWeight(.heavy)
            .foregroundStyle(.green)
    }
    
    // MARK: - Normal Price
    @ViewBuilder
    func normalPriceText() -> some View {
        Text(normalPrice)
            .font(.caption)
            .strikethrough()
            .foregroundStyle(.gray)
    }
    
    // MARK: - Savings
    @ViewBuilder
    func savingsText() -> some View {
        Text(savings)
            .font(.body)
            .fontWeight(.bold)
            .foregroundStyle(.green)
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
                    .frame(width: 170, height: 100)
                    .clipped()
                    .cornerRadius(3)
                    .overlay {
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.1),
                                                                   Color.black.opacity(0.85)]),
                                             startPoint: .top,
                                       endPoint: .bottom)
                    }
                    
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

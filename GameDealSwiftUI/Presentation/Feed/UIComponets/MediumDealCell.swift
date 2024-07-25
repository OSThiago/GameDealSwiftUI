//
//  MediumDealCell.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 23/06/23.
//

import SwiftUI

struct MediumDealCell: View {
    // Properties
    let title: String
    let salePrice: String
    let normalPrice: String
    let savings: String
    var thumb: String
    let storeThumb: String
    
    // Constants
    private let cellWidth: CGFloat = ScreenSize.width * 0.45
    private let imageHight: CGFloat = ScreenSize.width * 0.45 * 9/16
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                gameImage()
                
                gameTitleText()
                    .padding(Tokens.padding.nano)
            }
            .cornerRadius(Tokens.borderRadius.sm)

            HStack(alignment: .bottom, spacing: Tokens.padding.quarck) {
                salePriceText()
                
                normalPriceText()
                
                Spacer()
                
                savingsText()
            }
            
        }
        .frame(width: cellWidth)
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
                    .frame(width: cellWidth, height: imageHight)
                    .clipped()
                    .overlay {
                        LinearGradient(
                            gradient: 
                                Gradient(
                                    colors: [Color.black.opacity(Tokens.opacity.transparent),
                                             Color.black.opacity(Tokens.opacity.intense)]),
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
}

struct MediumDealCell_Previews: PreviewProvider {
    static var previews: some View {
        MediumDealCell(title: FeedGameDealModel.riseOfIndustryMock.title, salePrice: FeedGameDealModel.riseOfIndustryMock.salePrice, normalPrice: FeedGameDealModel.riseOfIndustryMock.normalPrice, savings: FeedGameDealModel.riseOfIndustryMock.savings, thumb: FeedGameDealModel.riseOfIndustryMock.thumb, storeThumb: FeedGameDealModel.riseOfIndustryMock.storeID)
    }
}

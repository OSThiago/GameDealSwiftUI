//
//  ListDealCell.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 24/06/23.
//

import SwiftUI

struct ListDealCell: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    // Properties
    let title: String
    let salePrice: String
    let normalPrice: String
    let savings: String
    var thumb: String
    let storeThumb: String
    
    // Constants
    private let cellHeight: CGFloat = 80
    private let imageWidth: CGFloat = 80 * 16/9
    private let imageHeight: CGFloat = 80
    
    var body: some View {
        HStack {
            gameImage()
            
            VStack(alignment: .leading) {
                HStack {
                    gameTitleText()
                }
                Spacer()
                HStack(alignment: .bottom, spacing: Tokens.padding.quarck) {
                    salePriceText()
                    normalPriceText()
                    Spacer()
                    savingsText()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: cellHeight)
    }
    
    // MARK: - Game Title
    @ViewBuilder
    func gameTitleText() -> some View {
        Text(title)
            .font(.body)
            .fontWeight(.medium)
            .foregroundStyle(colorScheme == .light ? Color.black : Color.white)
            .multilineTextAlignment(.leading)
    }
    
    // MARK: - Sale price
    @ViewBuilder
    func salePriceText() -> some View {
        Text(salePrice)
            .font(.body)
            .fontWeight(.bold)
            .foregroundStyle(Color.green)
    }
    
    // MARK: - Normal Price
    @ViewBuilder
    func normalPriceText() -> some View {
        Text(normalPrice)
            .font(.footnote)
            .fontWeight(.medium)
            .strikethrough()
            .foregroundStyle(Color.gray)
    }
    
    // MARK: - Savings
    @ViewBuilder
    func savingsText() -> some View {
        Text(savings)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(Color.green)
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
                    .frame(width: imageWidth, height: imageHeight)
                    .clipped()
                    .cornerRadius(Tokens.borderRadius.sm)
                    
            case .failure(_):
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct ListDealCell_Previews: PreviewProvider {
    static var previews: some View {
        ListDealCell(title: FeedGameDealModel.riseOfIndustryMock.title, salePrice: FeedGameDealModel.riseOfIndustryMock.salePrice, normalPrice: FeedGameDealModel.riseOfIndustryMock.normalPrice, savings: FeedGameDealModel.riseOfIndustryMock.savings, thumb: FeedGameDealModel.riseOfIndustryMock.thumb, storeThumb: StoresCheapShark.steamMock.images.banner)
    }
}

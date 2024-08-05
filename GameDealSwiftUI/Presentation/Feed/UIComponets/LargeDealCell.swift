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
    let store: String
    
    private let cellWidth: CGFloat = ScreenSize.width - Tokens.padding.xs
    private let cellHight: CGFloat = 200
    private let storeImageSize: CGFloat = 40

    var body: some View {
        VStack(spacing: Tokens.padding.none) {
            ZStack(alignment: .bottomLeading) {
                gameImage()
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 4) {
                        gameTitleText()
                        storeName()
                    }
                    
                    Spacer()
                    
                    StoreImage(storeImage: storeThumb,
                               size: storeImageSize)
                }
                .padding(Tokens.padding.nano)
            }
            
            HStack(alignment: .bottom, spacing: Tokens.padding.micro) {
                salePriceText()
                
                normalPriceText()
                    .padding(.bottom, 2)
                
                Spacer()
                
                Savings(savings: savings,
                        font: .title3,
                        padding: Tokens.padding.nano)
            }
            .padding(.horizontal, Tokens.padding.xxxs)
            .padding(.vertical, Tokens.padding.micro)
        }
        .frame(maxWidth: cellWidth)
        .background(RoundedRectangle(cornerRadius: Tokens.borderRadius.md)
            .fill(Color(uiColor: UIColor.systemBackground))
            .shadow(ShadowLevel.level1)
        )
        .padding(.bottom, Tokens.padding.xxxs)
    }
    
    // MARK: - Game Title
    @ViewBuilder
    func gameTitleText() -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .multilineTextAlignment(.leading)
            .foregroundStyle(Color.white)
    }
    
    // MARK: - Sale price
    @ViewBuilder
    func salePriceText() -> some View {
        Text(salePrice)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundStyle(Tokens.color.positive.secondary)
    }
    
    // MARK: - Normal Price
    @ViewBuilder
    func normalPriceText() -> some View {
        Text(normalPrice)
            .font(.callout)
            .fontWeight(.regular)
            .strikethrough()
            .foregroundStyle(.gray)
    }
    
    // MARK: - Savings
    @ViewBuilder
    func savingsText() -> some View {
        Text(savings)
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.green)
    }
    
    // MARK: - Store Name
    @ViewBuilder
    func storeName() -> some View {
        Text(store)
            .font(.headline)
            .fontWeight(.regular)
            .foregroundStyle(Tokens.color.neutral.primary)
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
                    .frame(width: cellWidth, height: cellHight)
                    .clipped()
                    .clipShape(.rect(
                        topLeadingRadius: Tokens.borderRadius.md,
                        topTrailingRadius: Tokens.borderRadius.md))
                    .overlay {
                        LinearGradient(
                            gradient: Gradient(
                                colors: [Color.white.opacity(Tokens.opacity.transparent),
                                         Color.black.opacity(Tokens.opacity.intense)
                                        ]),
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

struct LargeDealCell_Previews: PreviewProvider {
    static var previews: some View {
        let mock = FeedGameDealModel.riseOfIndustryMock
        let storeMock = StoreImagesCheapShark.steamMockImages.icon
        
        LargeDealCell(title: mock.title, salePrice: mock.salePrice, normalPrice: mock.normalPrice, savings: mock.savings, thumb: mock.thumb, storeThumb: storeMock, store: "Steam")
    }
}

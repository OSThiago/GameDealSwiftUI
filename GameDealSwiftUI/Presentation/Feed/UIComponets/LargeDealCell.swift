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
    
    private let cellWidth: CGFloat = ScreenSize.width - Tokens.padding.xs
    private let cellHight: CGFloat = 200
    private let storeImageSize: CGFloat = 40

    var body: some View {
        VStack(spacing: Tokens.padding.none) {
            ZStack(alignment: .bottomLeading) {
                gameImage()
                
                HStack(alignment: .bottom) {
                    gameTitleText()
                    
                    Spacer()
                    
                    StoreImage(storeImage: storeThumb,
                               size: storeImageSize)
                }
                .padding(Tokens.padding.nano)
            }
            
            HStack(alignment: .bottom) {
                salePriceText()
                
                normalPriceText()
                
                Spacer()
                
                savingsText()
            }
            .padding(Tokens.padding.nano)
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
            .multilineTextAlignment(.leading)
            .foregroundStyle(Color.white)
    }
    
    // MARK: - Sale price
    @ViewBuilder
    func salePriceText() -> some View {
        Text(salePrice)
            .font(.title2)
            .fontWeight(.heavy)
            .foregroundStyle(.green)
    }
    
    // MARK: - Normal Price
    @ViewBuilder
    func normalPriceText() -> some View {
        Text(normalPrice)
            .font(.subheadline)
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
                                         Color.black.opacity(Tokens.opacity.semiIntense)
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
        
        LargeDealCell(title: mock.title, salePrice: mock.salePrice, normalPrice: mock.normalPrice, savings: mock.savings, thumb: mock.thumb, storeThumb: storeMock)
    }
}

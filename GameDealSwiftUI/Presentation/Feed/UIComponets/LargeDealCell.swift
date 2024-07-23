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
    
    private let cellWidth = ScreenSize.width - 32
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                // Thumb
                gameImage()
                
                HStack(alignment: .bottom) {
                    gameTitleText()
                    
                    Spacer()
                    
                    storeImage()
                }
                .padding(8)
            }
            
            HStack(alignment: .bottom) {
                salePriceText()
                
                normalPriceText()
                
                Spacer()
                
                savingsText()
            }
            .padding(8)
        }
        .frame(maxWidth: cellWidth)
        .background(RoundedRectangle(cornerRadius: 8)
            .fill(Color(uiColor: UIColor.systemBackground))
            .shadow(color: Color.gray.opacity(0.2), radius: 8, y: 4)
        )
        .padding(.bottom, 16)
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
                    .frame(width: cellWidth, height: 200)
                    .clipped()
                    .clipShape(.rect(topLeadingRadius: 8, topTrailingRadius: 8))
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

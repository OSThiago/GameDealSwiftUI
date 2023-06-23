//
//  LargeDealCell.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

//extension String {
//    func load() -> UIImage {
//        do {
//            guard let url = URL(string: self) else {
//                return UIImage()
//            }
//
//            let data: Data = try Data(contentsOf: url)
//
//            return UIImage(data: data) ?? UIImage()
//        } catch {
//
//        }
//        return UIImage()
//    }
//}

struct LargeDealCell: View {
    
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
            Divider()
        }
        .frame(maxWidth: 330)
    }
    
    // MARK: - Game Title
    @ViewBuilder
    func gameTitleText() -> some View {
        Text(title)
    }
    
    // MARK: - Sale price
    @ViewBuilder
    func salePriceText() -> some View {
        Text(salePrice)
            .bold()
    }
    
    // MARK: - Normal Price
    @ViewBuilder
    func normalPriceText() -> some View {
        Text(normalPrice)
            .strikethrough()
    }
    
    // MARK: - Savings
    @ViewBuilder
    func savingsText() -> some View {
        Text(savings)
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
                    .frame(width: 330, height: 200)
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

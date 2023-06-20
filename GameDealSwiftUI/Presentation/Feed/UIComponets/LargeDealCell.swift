//
//  LargeDealCell.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

extension String {
    func load() -> UIImage {
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage()
        } catch {
            
        }
        return UIImage()
    }
}

struct LargeDealCell: View {
    
    let title: String
    let salePrice: String
    let normalPrice: String
    let savings: String
    let thumb: String
    let storeThumb: String
    
    var body: some View {
        VStack {
            // Thumb
            AsyncImage(url: URL(string: thumb)) { phase in
                switch phase  {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 330, height: 157)
                        .clipped()
                        
                case .failure(_):
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
                
                .frame(maxWidth: 330, maxHeight: 157)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                    
                    HStack {
                        Text(salePrice)
                        Text(normalPrice)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Image(uiImage: storeThumb.load())
                        .resizable()
                        .frame(maxWidth: 31, maxHeight: 31)
                    
                    Text(savings)
                }
            }
        }
        .frame(maxWidth: 330)
    }
}

struct LargeDealCell_Previews: PreviewProvider {
    static var previews: some View {
        let mock = FeedGameDealModel.riseOfIndustryMock
        let storeMock = StoreImagesCheapShark.steamMockImages.icon
        
        LargeDealCell(title: mock.title, salePrice: mock.salePrice, normalPrice: mock.normalPrice, savings: mock.savings, thumb: mock.thumb, storeThumb: storeMock)
    }
}

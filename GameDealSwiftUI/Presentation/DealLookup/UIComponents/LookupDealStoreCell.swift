//
//  LookupDealStoreCell.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 04/07/23.
//

import SwiftUI

struct LookupDealStoreCell: View {
    
    let storeImage: String?
    let storeTitle: String?
    let dealPrice: String?
    let isCheaper: Bool
    
    private let cellWidth: CGFloat?
    private let cellHeight: CGFloat = 50
    private let unknown: String = "unknown"
    private let storeImageSize: CGFloat = 40
    
    init(storeImage: String?,
         storeTitle: String?,
         dealPrice: String?,
         isCheaper: Bool = false,
         cellWidth: CGFloat? = nil) {
        self.storeImage = storeImage
        self.storeTitle = storeTitle
        self.dealPrice = dealPrice
        self.isCheaper = isCheaper
        self.cellWidth = cellWidth
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(alignment: .center) {
            storeImageComponent
            storeTitleComponent
            Spacer()
            dealPriceComponent
        }
        .frame(width: cellWidth, height: cellHeight)
        .padding(.horizontal)
    }
}

// MARK: - DEAL PRICE
extension LookupDealStoreCell {
    @ViewBuilder
    var dealPriceComponent: some View {
        Text("$\(dealPrice ?? "")")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(isCheaper ? Tokens.color.positive.secondary : Color.primary)
    }
}

// MARK: - STORE TITLE
extension LookupDealStoreCell {
    @ViewBuilder
    var storeTitleComponent: some View {
        Text(storeTitle ?? unknown)
            .font(.body)
            .fontWeight(.medium)
    }
}

// MARK: - STORE IMAGE
extension LookupDealStoreCell {
    @ViewBuilder
    var storeImageComponent: some View {
        AsyncImage(url: URL(string: storeImage ?? unknown)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: storeImageSize, height: storeImageSize)
                    
            case .failure(_):
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct LookupDealStoreCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LookupDealStoreCell(storeImage: StoreImagesCheapShark.steamMockImages.logo, storeTitle: StoresCheapShark.steamMock.storeName, dealPrice: "0.00", isCheaper: false, cellWidth: nil)
            
            LookupDealStoreCell(storeImage: StoreImagesCheapShark.steamMockImages.logo, storeTitle: StoresCheapShark.steamMock.storeName, dealPrice: "0.00", isCheaper: true, cellWidth: nil)
        }
    }
}

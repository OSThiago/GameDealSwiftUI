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
    
    private let cellWidth: CGFloat = 330
    private let cellHeignt: CGFloat = 50
    private let unknown: String = "unknown"
    private let storeImageSize: CGFloat = 40
    
    // MARK: - BODY
    var body: some View {
        HStack(alignment: .center) {
            storeImageComponent
            storeTitleComponent
            Spacer()
            dealPriceComponent
        }
        .frame(width: cellWidth, height: cellHeignt)
        .padding(.leading)
    }
}

// MARK: - DEAL PRICE
extension LookupDealStoreCell {
    @ViewBuilder
    var dealPriceComponent: some View {
        Text("$\(dealPrice ?? "")")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(Color.primary )
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
        LookupDealStoreCell(storeImage: StoreImagesCheapShark.steamMockImages.banner, storeTitle: StoresCheapShark.steamMock.storeName, dealPrice: "0.00", isCheaper: true)
    }
}

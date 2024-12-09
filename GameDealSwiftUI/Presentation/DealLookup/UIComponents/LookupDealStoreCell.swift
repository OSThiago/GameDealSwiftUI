//
//  LookupDealStoreCell.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 04/07/23.
//

import SwiftUI

struct LookupDealStoreCell: View {
    
    @Injected private var formatterUseCase: FormatterProcol
    
    let storeImage: String?
    let storeTitle: String?
    let dealPrice: String?
    let isOnSale: Bool
    
    private let cellWidth: CGFloat?
    private let cellHeight: CGFloat = 50
    private let unknown: String = "unknown"
    private let storeImageSize: CGFloat = 40
    
    init(storeImage: String?,
         storeTitle: String?,
         dealPrice: String?,
         isOnSale: Bool = false,
         cellWidth: CGFloat? = nil
    ) {
        self.storeImage = storeImage
        self.storeTitle = storeTitle
        self.dealPrice = dealPrice
        self.isOnSale = isOnSale
        self.cellWidth = cellWidth
    }
    
    // MARK: - BODY
    var body: some View {
        HStack(alignment: .center) {
            StoreImage(storeImage: storeImage ?? unknown,
                       size: storeImageSize)

            titleComponent

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
            .foregroundStyle(isOnSale ? Tokens.color.positive.secondary : Color.primary)
    }
}

// MARK: - STORE TITLE
extension LookupDealStoreCell {
    @ViewBuilder
    var titleComponent: some View {
        Text(storeTitle ?? unknown)
            .font(.body)
            .fontWeight(.medium)
    }
}

struct LookupDealStoreCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LookupDealStoreCell(storeImage: StoreImagesCheapShark.steamMockImages.logo, storeTitle: StoresCheapShark.steamMock.storeName, dealPrice: "0.00", isOnSale: false, cellWidth: nil)
            
            LookupDealStoreCell(storeImage: StoreImagesCheapShark.steamMockImages.logo, storeTitle: StoresCheapShark.steamMock.storeName, dealPrice: "10.00", isOnSale: true, cellWidth: nil)
        }
    }
}

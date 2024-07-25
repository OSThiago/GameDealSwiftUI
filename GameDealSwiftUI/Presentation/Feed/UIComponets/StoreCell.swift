//
//  StoreCell.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 23/06/23.
//

import SwiftUI

struct StoreCell: View {
    // Properties
    let storeName: String
    let storeBanner: String
    
    // Constants
    private let cellWidth: CGFloat = ScreenSize.width - Tokens.padding.md
    private let cellHight: CGFloat = 50
    private let storeImageSize: CGFloat = 40
    
    var body: some View {
        HStack {
            StoreImage(storeImage: storeBanner,
                       size: storeImageSize)
            name()
            Spacer()
        }
        .frame(width: cellWidth, height: cellHight)
        .padding(.leading)
    }
    
    @ViewBuilder
    func name() -> some View {
        Text(storeName)
            .font(.body)
            .fontWeight(.bold)
    }
}

struct StoreCell_Previews: PreviewProvider {
    static var previews: some View {
        StoreCell(storeName: StoresCheapShark.steamMock.storeName, storeBanner: StoresCheapShark.steamMock.images.banner)
    }
}

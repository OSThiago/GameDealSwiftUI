//
//  StoreCell.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 23/06/23.
//

import SwiftUI

struct StoreCell: View {
    
    let storeName: String
    let storeBanner: String
    
    var body: some View {
        HStack {
            storeImage()
            name()
            Spacer()
        }
        .frame(width: 330, height: 50)
        .padding(.leading)
    }
    
    @ViewBuilder
    func name() -> some View {
        Text(storeName)
            .font(.body)
            .fontWeight(.bold)
    }
    
    // MARK: - Store Image
    @ViewBuilder
    func storeImage() -> some View {
        AsyncImage(url: URL(string: storeBanner)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    
            case .failure(_):
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct StoreCell_Previews: PreviewProvider {
    static var previews: some View {
        StoreCell(storeName: StoresCheapShark.steamMock.storeName, storeBanner: StoresCheapShark.steamMock.images.banner)
    }
}

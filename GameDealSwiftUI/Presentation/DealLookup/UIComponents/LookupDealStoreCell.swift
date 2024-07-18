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
    
    // MARK: - BODY
    var body: some View {
        HStack(alignment: .center) {
            makeStoreImage()
            makeStoreTitle()
            Spacer()
            makeDealPrice()
        }
        .frame(width: 330, height: 50)
        .padding(.leading)
    }
    
    // MARK: - DEAL PRICE
    @ViewBuilder
    func makeDealPrice() -> some View {
        Text("$\(dealPrice ?? "")")
            .font(.body)
            .fontWeight(.bold)
    }
    
    // MARK: - STORE TITLE
    @ViewBuilder
    func makeStoreTitle() -> some View {
        Text(storeTitle ?? "Unkow")
            .font(.body)
            .fontWeight(.bold)
    }
    
    // MARK: - STORE IMAGE
    @ViewBuilder
    func makeStoreImage() -> some View {
        AsyncImage(url: URL(string: storeImage ?? "Unkown")) { phase in
            switch phase  {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    //.clipped()
                    
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
        LookupDealStoreCell(storeImage: StoreImagesCheapShark.steamMockImages.banner, storeTitle: StoresCheapShark.steamMock.storeName, dealPrice: "0.00")
    }
}

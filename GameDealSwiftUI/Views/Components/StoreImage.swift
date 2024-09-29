//
//  StoreImageView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 24/07/24.
//

import SwiftUI

struct StoreImage: View {
    
    let storeImage: String
    let size: CGFloat
    
    init(storeImage: String, size: CGFloat) {
        self.storeImage = storeImage
        self.size = size
    }
    
    var body: some View {
        AsyncImage(url: URL(string: storeImage)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
                    .frame(width: size, height: size)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipped()
                    
            case .failure(_):
                // TODO: Criar ou adicionar em um token de simbolos
                Image(systemName: "photo.artframe")
                    .foregroundStyle(Tokens.color.neutral.primary)
                    .frame(width: size, height: size)
            @unknown default:
                Image(systemName: "photo.artframe")
                    .foregroundStyle(Tokens.color.neutral.primary)
                    .frame(width: size, height: size)
            }
        }
    }
}

#Preview {
    StoreImage(storeImage: "https://www.cheapshark.com/img/stores/logos/0.png",
                   size: 50)
}

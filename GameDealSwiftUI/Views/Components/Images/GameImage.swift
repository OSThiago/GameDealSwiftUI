//
//  GameImage.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 19/11/24.
//

import SwiftUI

struct GameImage: View {
    
    let url: String
    let width: CGFloat
    let height: CGFloat
    let placeholder: String
    
    init(url: String,
          width: CGFloat,
          height: CGFloat,
          placeholder: String = "photo.artframe"
    ) {
        self.url = url
        self.width = width
        self.height = height
        self.placeholder = placeholder
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()

            case .failure(_):
                // TODO: Criar ou adicionar em um token de simbolos
                Image(systemName: placeholder)
                    .foregroundStyle(Tokens.color.neutral.primary)
                    .frame(width: width, height: height)
            @unknown default:
                Image(systemName: placeholder)
                    .foregroundStyle(Tokens.color.neutral.primary)
                    .frame(width: width, height: height)
            }
        }
    }
}

#Preview {
    GameImage(url: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/20920/header.jpg?t=1729586898",
              width: 300,
              height: 300 / 16*9,
              placeholder: "photo.artframe")
}

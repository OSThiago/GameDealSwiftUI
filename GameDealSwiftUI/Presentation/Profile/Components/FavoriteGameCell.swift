//
//  FavoriteGameCell.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 03/12/24.
//

import SwiftUI

struct FavoriteGameCell: View {
    
    @Injected private var formatterUseCase: FormatterProcol
    
    let image: String
    let name: String
    let price: String
    let savings: String
    let originalPrice: String
    var notificationIsActive: Bool
    var notificationAction: () -> Void
    
    var body: some View {
        HStack {
            gameImageView
            
            VStack(alignment: .leading) {
                gameNameView
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    currentPriceView
                    
                    if isOnSale() {
                        originalPriceView
                        
                        Savings(savings: formatterUseCase.formatSavings(savings),
                                font: .subheadline,
                                padding: Tokens.padding.quarck)
                        .padding(.leading, 4)
                    } else {
                        Text("no deals")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
            
            Spacer()
            
            notificationButton
        }
    }
    
    func isOnSale() -> Bool {
        return originalPrice != price
    }
}

// MARK: - Image
extension FavoriteGameCell {
    var gameImageView: some View {
        GameImage(url: formatterUseCase.getHightQualityImage(url: image),
                  width: 60 * 16/9,
                  height: 60)
        .clipShape(.rect(cornerRadius: Tokens.borderRadius.sm))
    }
}

// MARK: - Name
extension FavoriteGameCell {
    var gameNameView: some View {
        Text(name)
            .foregroundStyle(.black)
            .font(.headline)
            .lineLimit(2)
    }
}

// MARK: - Deal Price
extension FavoriteGameCell {
    var currentPriceView: some View {
        Text("$\(price)")
            .font(.callout)
            .fontWeight(.semibold)
            .foregroundStyle(isOnSale() ? Tokens.color.positive.secondary : .primary)
    }
}

// MARK: - Original Price
extension FavoriteGameCell {
    var originalPriceView: some View {
        Text("$\(originalPrice)")
            .font(.caption)
            .strikethrough()
            .foregroundStyle(.gray)
    }
}

// MARK: - Notification Button
extension FavoriteGameCell {
    var notificationButton: some View {
        Image(systemName: notificationIsActive ? "bell.fill" : "bell")
            .scaleEffect(1.3)
            .onTapGesture {
                self.notificationAction()
            }
    }
}

#Preview {
    @Previewable @State var notificationIsActive: Bool = false
    FavoriteGameCell(image: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/7670/capsule_sm_120.jpg?t=1730172622",
                     name: "BioShock",
                     price: "4.99",
                     savings: "75.037519",
                     originalPrice: "19.99",
                     notificationIsActive: $notificationIsActive.wrappedValue
                     , notificationAction: {
            notificationIsActive.toggle()
    })
    .padding(.horizontal, 16)
}

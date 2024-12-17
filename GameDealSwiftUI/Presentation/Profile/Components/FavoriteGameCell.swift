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
        HStack(alignment: .top) {
            gameImageView
            
            VStack(alignment: .leading, spacing: 0) {
                gameNameView
                
                HStack(alignment: .bottom) {
                    currentPriceView
                    
                    if isOnSale() {
                        originalPriceView

                        Spacer()
                        
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
                .frame(maxWidth: 185, alignment: .leading)
            }
            
            Spacer()
            
            notificationButton
        }
        .frame(height: 70)
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
                  height: 70)
        .background(.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: Tokens.borderRadius.sm))
    }
}

// MARK: - Name
extension FavoriteGameCell {
    var gameNameView: some View {
        Text(name)
            .foregroundStyle(.black)
            .font(.body)
            .fontWeight(.semibold)
            .lineLimit(2)
            .frame(height: 45, alignment: .topLeading)
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
    
    VStack {
        FavoriteGameCell(image: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/7670/capsule_sm_120.jpg?t=1730172622",
                         name: "BioShock",
                         price: "4.99",
                         savings: "75.037519",
                         originalPrice: "19.99",
                         notificationIsActive: $notificationIsActive.wrappedValue
                         , notificationAction: {
                notificationIsActive.toggle()
        })
        
        FavoriteGameCell(image: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/315210/672afecc3038d133ad819dc76599c80179fcc8ea/capsule_sm_120_alt_assets_5.jpg?t=1733850022",
                         name: "Suicide Squad: Kill the Justice League - Digital Deluxe Edition",
                         price: "25.00",
                         savings: "50.00",
                         originalPrice: "50.00",
                         notificationIsActive: $notificationIsActive.wrappedValue
                         , notificationAction: {
                notificationIsActive.toggle()
        })
        
        FavoriteGameCell(image: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/1677350/capsule_sm_120.jpg?t=1713879504",
                         name: "EA SPORTS PGA TOUR",
                         price: "200.00",
                         savings: "50.0",
                         originalPrice: "100.00",
                         notificationIsActive: $notificationIsActive.wrappedValue
                         , notificationAction: {
                notificationIsActive.toggle()
        })
        
        FavoriteGameCell(image: "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/7670/capsule_sm_120.jpg?t=1730172622",
                         name: "BioShock",
                         price: "19.99",
                         savings: "0.0",
                         originalPrice: "19.99",
                         notificationIsActive: $notificationIsActive.wrappedValue
                         , notificationAction: {
                notificationIsActive.toggle()
        })
    }
    
    
    .padding(.horizontal, 16)
}

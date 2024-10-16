//
//  DealLookupView+DealDetails.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 20/07/23.
//

import SwiftUI
 
// MARK: - Game Image
extension DealLookupView {
    @ViewBuilder
    var gameImage: some View {
        
        let url = viewModel.FormatterUseCase.getHightQualityImage(url: viewModel.feedGameDealModel.thumb)
        
        let imageHeight = constants.gameImageHeight
        
        AsyncImage(url: URL(string: url)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
                    .frame(width: ScreenSize.width, height: imageHeight)
            case .success(let image):
                GeometryReader { reader in
                    let offsetY = reader.frame(in: .global).minY
                    let isScrolled = offsetY > 0
                    
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: ScreenSize.width, height: isScrolled ? offsetY + imageHeight : imageHeight)
                        .clipped()
                        
                        .offset(y: isScrolled ? -offsetY : 0)
                        .scaleEffect(isScrolled ? offsetY / 2000 + 1 : 1)
                }
                // Default frame
                .frame(height: imageHeight)
                    
            case .failure(_):
                // TODO: Criar ou adicionar em um token de simbolos
                Image(systemName: "photo.artframe")
                    .foregroundStyle(Tokens.color.neutral.primary)
                    .scaleEffect(2)
                    .frame(width: ScreenSize.width, height: imageHeight)
            @unknown default:
                Image(systemName: "photo.artframe")
                    .frame(width: ScreenSize.width, height: imageHeight)
                    .foregroundStyle(Tokens.color.neutral.primary)
            }
        }
    }
}

// MARK: - BACK BUTTON
extension DealLookupView {
    @ViewBuilder
    func backButton() -> some View {
        Button {
            router.pop()
        } label: {
            Image(systemName: constants.backButtonIcon)
                .foregroundColor(Color.white)
                .shadow(radius: Tokens.borderRadius.xs)
        }
    }
}

// MARK: - Deal Detail Section
extension DealLookupView {
    @ViewBuilder
    var dealDetailSection: some View {
        VStack(alignment: .leading, spacing: Tokens.padding.quarck) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: Tokens.padding.quarck) {
                    gameTitle
                                    
                    storeName
                }
                
                Spacer()
                
                StoreImage(storeImage: viewModel.FormatterUseCase.getStoreImage(store: viewModel.store),
                           size: constants.storeImageSize)
            }
            .padding(.bottom, Tokens.padding.xs)

            
            HStack(alignment: .bottom) {
                
                salePrice

                normalPrice

                Spacer()
                
                buyButton(dealID: "game id")
            }
            
            Divider()
                .padding(.top, Tokens.padding.nano)
        }
        .padding(.horizontal, Tokens.padding.xxxs)
        .padding(.bottom, Tokens.padding.xxxs)
    }
}

// MARK: - Game Title
extension DealLookupView {
    @ViewBuilder
    var gameTitle: some View {
        Text(viewModel.feedGameDealModel.title)
            .font(.title2)
            .fontWeight(.semibold)
    }
}

// MARK: - Sale Price
extension DealLookupView {
    @ViewBuilder
    var salePrice: some View {
        Text("$\(viewModel.feedGameDealModel.salePrice)")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(Tokens.color.positive.secondary)
    }
}

// MARK: - Normal Price
extension DealLookupView {
    @ViewBuilder
    var normalPrice: some View {
        Text("$\(viewModel.feedGameDealModel.normalPrice)")
            .font(.subheadline)
            .fontWeight(.regular)
            .strikethrough()
            .foregroundStyle(Tokens.color.neutral.primary)
    }
}

// MARK: - Store Name
extension DealLookupView {
    var storeName: some View {
        Text(viewModel.store.storeName)
            .font(.body)
            .fontWeight(.medium)
            .foregroundStyle(Tokens.color.neutral.primary)
    }
}

// MARK: - Buy Button
extension DealLookupView {
    @ViewBuilder
    func buyButton(dealID: String) -> some View {
        Button {
            print("\(constants.buy) - \(dealID)")
        } label: {
            Text(constants.buy)
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .frame(width: constants.buyButtonWidth,
                       height: constants.buyButtonHeight)
        }
        .background(Color.blue)
        .clipShape(.rect(cornerRadius: Tokens.borderRadius.lg))
    }
}

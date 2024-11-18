//
//  GameDetailView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 08/11/24.
//

import SwiftUI

struct GameDetailView: View {
    
    @EnvironmentObject var router: Router
    
    @StateObject var viewModel: GameDetailViewModel
    
    @State var width: CGFloat = 0
    @State var height: CGFloat = 0
    
    init(viewModel: GameDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .statusBarHidden()
            .task {
                await viewModel.viewDidLoad()
            }
    }
}

extension GameDetailView {
    var content: some View {
        ScrollView {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: 16) {

                    let hightQualityImage = viewModel.formatterUseCase.getHightQualityImage(url: viewModel.gameLookupModel?.info?.thumb ?? "error")
                    
                    gameImage(url: hightQualityImage)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.gameLookupModel?.info?.title ?? "error")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        cheapestPriceEver
                    }
                    .padding(.horizontal, 16)
                    
//                    storesDeals
                    verticalList
                    
                    GameDetailsSection(metacriticData: viewModel.metacriticDetailModel)
                        .padding(.horizontal, 16)
                }
                
                dismissButton
                    .padding(24)
                    .padding(.top, 16)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    var dismissButton: some View {
        Button {
            router.dismissFullScreenCover()
        } label: {
            Image(systemName: "x.circle.fill")
                .tint(.white)
                .shadow(color: .black, radius: 4)
                .scaleEffect(1.5)
        }
    }
    
    @ViewBuilder
    var cheapestPriceEver: some View {
        if let cheapeastPrice =  viewModel.gameLookupModel?.cheapestPriceEver?.price {
            HStack {
                Text(viewModel.gameLookupModel?.cheapestPriceEver?.date.description ?? "nil")
                
                Spacer()
                
                Text("$\(cheapeastPrice)")
                    
            }
            .font(.body)
            .foregroundStyle(.gray)
        }
    }
    
    @ViewBuilder
    var storesDeals: some View {
        if let deals = viewModel.gameLookupModel?.deals {
            let rows = [
                GridItem(.fixed(50)),
                GridItem(.fixed(50)),
                GridItem(.fixed(50))
            ]
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Stores Deals")
                    .font(.body)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, spacing: 0) {
                        ForEach(deals, id: \.dealID) { deal in
                            if let store = viewModel.getStore(storeID: deal.storeID ?? "") {
                                let storeImage = viewModel.formatterUseCase.getStoreImage(store: store)
                                LookupDealStoreCell(storeImage: storeImage,
                                                    storeTitle: store.storeName,
                                                    dealPrice: deal.price,
                                                    isCheaper: false,
                                                    cellWidth: 340)
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
            }
        }
    }
    
    var verticalList: some View {
        VStack {
            ForEach(viewModel.gameLookupModel?.deals ?? [], id: \.dealID) { deal in
                if let store = viewModel.getStore(storeID: deal.storeID ?? "") {
                    let storeImage = viewModel.formatterUseCase.getStoreImage(store: store)
                    LookupDealStoreCell(storeImage: storeImage,
                                        storeTitle: store.storeName,
                                        dealPrice: deal.price,
                                        isCheaper: viewModel.isCheaper(value: deal.price))
                }
            }
        }
    }
}

extension GameDetailView {
    @ViewBuilder
    func gameImage(url: String) -> some View {

        let cellWidth = ScreenSize.width
        let cellHeight = cellWidth / 16*9
        
        AsyncImage(url: URL(string: url)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
                    .frame(width: cellWidth, height: cellHeight)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: cellWidth, height: cellHeight)
                    .clipped()

            case .failure(_):
                // TODO: Criar ou adicionar em um token de simbolos
                Image(systemName: "photo.artframe")
                    .foregroundStyle(Tokens.color.neutral.primary)
                    .frame(width: cellWidth, height: cellHeight)
            @unknown default:
                Image(systemName: "photo.artframe")
                    .foregroundStyle(Tokens.color.neutral.primary)
                    .frame(width: cellWidth, height: cellHeight)
            }
        }
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126").configure()
}

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
                VStack {
                    gameImage(url: viewModel.gameLookupModel?.info?.thumb ?? "error")
                    
                    Text(viewModel.gameLookupModel?.info?.title ?? "error")
                }
                
                dismissButton
                    .padding(24)
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
}

extension GameDetailView {
    @ViewBuilder
    func gameImage(url: String) -> some View {
        
//        let cellWidth = 100.0
        let cellWidth = ScreenSize.width
        let cellHight = 100.0
        
        AsyncImage(url: URL(string: url)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
                    .frame(width: cellWidth)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: cellWidth)

            case .failure(_):
                // TODO: Criar ou adicionar em um token de simbolos
                Image(systemName: "photo.artframe")
                    .foregroundStyle(Tokens.color.neutral.primary)
                    .frame(width: cellWidth, height: cellHight)
            @unknown default:
                Image(systemName: "photo.artframe")
                    .foregroundStyle(Tokens.color.neutral.primary)
                    .frame(width: cellWidth, height: cellHight)
            }
        }
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126").configure()
}

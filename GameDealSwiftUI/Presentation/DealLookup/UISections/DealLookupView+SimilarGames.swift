//
//  DealLookup+SimilarGames.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 20/07/23.
//

import SwiftUI

extension DealLookupView {
    @ViewBuilder
    func makeSimilarGames(title: String, games: [RwGameDetailModel]) -> some View {
        VStack(alignment: .leading) {
            HStack {
                // Title
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding(.leading)
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -8) {
                    ForEach(games, id: \.id) { game in
                        makeSimilarGameCell(game: game)
                            .padding(.leading)
                    }
                }
            }
            
            Divider()
                .padding(.horizontal)
                .padding(.top, 16)
        }
    }
    
    @ViewBuilder
    private func makeSimilarGameCell(game: RwGameDetailModel) -> some View {
        VStack(alignment: .leading) {
            makeGameImage(gameImage: game.backgroundImage ?? "Unkow")
            
            Text(game.name ?? "Unkow")
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(width: 170, height: 50, alignment: .top)
            Spacer()
        }
    }
    
    @ViewBuilder
    private func makeGameImage(gameImage: String) -> some View {
        AsyncImage(url: URL(string: gameImage)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 100)
                    .clipped()
                    .cornerRadius(3)
                    
            case .failure(_):
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

//
//  DealLookupView+Genres.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/08/23.
//

import SwiftUI

extension DealLookupView {
    @ViewBuilder
    func makeGenres() -> some View {
        if let genres = viewModel.rwGameDetail?.genres {
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(genres, id: \.id) { genre in
                        genreComponent(text: genre.name ?? "Unkown")
                            .padding(.leading)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func genreComponent(text: String) -> some View {
        ZStack {
            Color(.systemBlue)
            
            Text(text)
        }
        
        .cornerRadius(5)
    }
}


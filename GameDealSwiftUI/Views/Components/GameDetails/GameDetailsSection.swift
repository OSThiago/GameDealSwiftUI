//
//  GameDetailsSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 18/11/24.
//

import SwiftUI

struct GameDetailsSection: View {
    
    let metacriticData: MetacriticDetailModel?
    
    var body: some View {
        content
    }
}

// MARK: - Content
extension GameDetailsSection {
    var content: some View {
        VStack(spacing: 8) {
            if let metacriticData {
                // Platforms
                GameDetailItem(items: metacriticData.platforms ?? [],
                               title: "Platforms")
                
                Divider()
                
                // Release Date
                GameDetailItem(items: [metacriticData.releaseDate ?? ""],
                               title: "Release Date")
                
                Divider()
                
                // Developers
                GameDetailItem(items: metacriticData.developers ?? [],
                               title: "Developers")
                
                Divider()
                
                // Publisher
                GameDetailItem(items: [metacriticData.publisher ?? ""],
                               title: "publisher")
                
                Divider()
                
                // Genres
                GameDetailItem(items: metacriticData.genres ?? [],
                               title: "Release Date")
                
                Divider()
                
                // Description
                GameDetailDescription(description: metacriticData.description ?? "")
            }
        }
    }
}

#Preview {
    GameDetailsSection(metacriticData: .thewitcher3)
        .padding(.horizontal, 16)
}

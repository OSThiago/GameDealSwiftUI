//
//  GameDetailsSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 18/11/24.
//

import SwiftUI

struct GameDetailsSection: View {
    
    @Environment(\.colorScheme) var colorScheme
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
                
                customDivider
                
                // Release Date
                GameDetailItem(items: [metacriticData.releaseDate ?? ""],
                               title: "Release Date")
                
                customDivider
                
                // Developers
                GameDetailItem(items: metacriticData.developers ?? [],
                               title: "Developers")
                
                customDivider
                
                // Publisher
                GameDetailItem(items: [metacriticData.publisher ?? ""],
                               title: "publisher")
                
                customDivider
                
                // Genres
                GameDetailItem(items: metacriticData.genres ?? [],
                               title: "Release Date")
                
                customDivider
                
                // Description
                GameDetailDescription(description: metacriticData.description ?? "")
            }
        }
    }
}

extension GameDetailsSection {
    var customDivider: some View {
        Divider()
            .background(colorScheme == .dark ? .white.opacity(0.6) : .gray.opacity(0.15))
    }
}

#Preview {
    GameDetailsSection(metacriticData: .thewitcher3)
        .padding(.horizontal, 16)
}

//
//  Percentage.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/07/24.
//

import SwiftUI

struct Savings: View {
    
    let savings: String
    let font: Font
    let padding: CGFloat
    
    var body: some View {
        ZStack {
            Text("-\(savings)%")
                .font(font)
                .fontWeight(.bold)
                .foregroundStyle(Tokens.color.positive.primary)
                
        }
        .padding(.horizontal, padding)
        .padding(.vertical, padding/2)
        .background(Tokens.color.positive.tertiary)
        .clipShape(.rect(cornerRadius: 4))
    }
}

#Preview {
    Savings(savings: "80",
            font: .footnote,
            padding: 4)
}

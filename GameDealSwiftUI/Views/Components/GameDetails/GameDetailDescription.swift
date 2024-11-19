//
//  GameDetailDescription.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 18/11/24.
//

import SwiftUI

struct GameDetailDescription: View {
    
    let description: String
    
    @State var isExpanded: Bool = false

    var body: some View {
        VStack(spacing: 4) {
            Text(description.replacingOccurrences(of: "DESCRIPTION:", with: ""))
                .frame(height: isExpanded ? nil : 100)

            HStack {
                Spacer()
                // Expand Button
                Button {
                    isExpanded.toggle()
                } label: {
                    Text(isExpanded ? "Show Less" : "Show More")
                }
            }
        }
    }
}

#Preview {
    GameDetailDescription(description: MetacriticDetailModel.thewitcher3.description ?? "")
        .padding(.horizontal, 16)
}

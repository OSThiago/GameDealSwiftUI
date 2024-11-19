//
//  GameDetailView+CheapestPriceSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 19/11/24.
//

import SwiftUI

extension GameDetailView {
    @ViewBuilder
    var cheapestPriceEver: some View {
        if let cheapestPriceEver =  viewModel.gameLookupModel?.cheapestPriceEver?.price {
            VStack(alignment: .leading) {
                // Title
                Text("Cheapest Price Ever")
                    .font(.body)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundStyle(.gray)

                HStack {
                    Text(viewModel.dateFormatted(dateInt: viewModel.gameLookupModel?.cheapestPriceEver?.date ?? 0))

                    Spacer()

                    Text("$\(cheapestPriceEver)")
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                        .strikethrough()
                }
            }
        }
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126").configure()
}

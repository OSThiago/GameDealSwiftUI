//
//  DealLookupView+GameDescription.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 21/07/23.
//

import SwiftUI

extension DealLookupView {
    @ViewBuilder
    func makeGameDescription() -> some View {
        if let description = viewModel.rwGameDetail?.descriptionRaw {
            VStack(alignment: .leading) {
                Text("Description")
                    .font(.title3)
                
                Text(description)
            }
            .padding(.horizontal)
        }
    }
}

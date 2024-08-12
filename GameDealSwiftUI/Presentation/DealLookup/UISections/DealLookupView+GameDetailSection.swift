//
//  DealLookupView+GameDetailSection.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 06/08/24.
//

import SwiftUI

extension DealLookupView {
    @ViewBuilder
    var gameDetailsSection: some View {
        VStack(alignment: .leading, spacing: Tokens.padding.xxxs) {
//            Text("Information")
//                .font(.body)
//                .fontWeight(.bold)
            
            if let metacriticModel = viewModel.metacriticDetailModel {
                // Platforms
                gameDescriptionItem(items: metacriticModel.platforms,
                                    title: constants.platforms)
                
                // Release Date
                gameDescriptionItem(item: metacriticModel.releaseDate,
                                    title: constants.releaseDate)

                // Developers
                gameDescriptionItem(items: metacriticModel.developers,
                                    title: constants.developers)
                
                // Publisher
                gameDescriptionItem(item: metacriticModel.publisher,
                                    title: constants.publisher)

                // Genres
                gameDescriptionItem(items: metacriticModel.genres,
                                    title: constants.genres)
                
                // Description
                gameDescription(description: metacriticModel.description.replacingOccurrences(of: "Description:", with: ""),
                                title: constants.description)
            } else {
                Text(constants.emptyMessage)
            }
        }
        .padding(.horizontal, Tokens.padding.xxxs)
        .padding(.bottom, constants.gameDetailCustomBottomPadding)
    }
}

extension DealLookupView {
    @ViewBuilder
    func gameDescriptionItem(items: [String], title: String) -> some View {
        if !items.isEmpty {
            VStack(alignment: .leading, spacing: Tokens.padding.quarck) {
                Text("\(title): ")
                    .font(.body)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundStyle(.gray)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(items, id: \.self) { item in
                            Text(item)
                                .font(.body)
                                .fontWeight(.regular)
                                .fontDesign(.rounded)
                        }
                    }
                }
                .scrollBounceBehavior(.basedOnSize, axes: .horizontal)
                .scrollIndicators(.hidden)
            }
        }
    }
}

extension DealLookupView {
    @ViewBuilder
    func gameDescriptionItem(item: String, title: String) -> some View {
        if !item.isEmpty {
            VStack(alignment: .leading, spacing: Tokens.padding.quarck) {
                Text("\(title): ")
                    .font(.body)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundStyle(.gray)
                
                Text(item)
                    .font(.body)
                    .fontWeight(.regular)
                    .fontDesign(.rounded)
            }
        }
    }
}

extension DealLookupView {
    @ViewBuilder
    func gameDescription(description: String, title: String) -> some View {
        if !description.isEmpty {
            VStack(alignment: .leading, spacing: Tokens.padding.quarck) {
                Text("\(title): ")
                    .font(.body)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundStyle(.gray)
                
                Text(description)
                    .font(.body)
                    .fontWeight(.regular)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

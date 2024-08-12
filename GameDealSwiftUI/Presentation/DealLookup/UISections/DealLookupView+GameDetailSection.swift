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
        VStack(alignment: .leading, spacing: 16) {
//            Text("Information")
//                .font(.body)
//                .fontWeight(.bold)
            
            if let metacriticModel = viewModel.metacriticDetailModel {
                // Platforms
                gameDescriptionItem(items: metacriticModel.platforms,
                                    title: "Platforms")
                
                // Release Date
                gameDescriptionItem(item: metacriticModel.releaseDate,
                                    title: "Release Date")

                // Developers
                gameDescriptionItem(items: metacriticModel.developers,
                                    title: "Developers")
                
                // Publisher
                gameDescriptionItem(item: metacriticModel.publisher,
                                    title: "Publisher")

                // Genres
                gameDescriptionItem(items: metacriticModel.genres,
                                    title: "Genres")
                
                // Description
                gameDescription(description: metacriticModel.description.replacingOccurrences(of: "Description:", with: ""),
                                    title: "Description")
            } else {
                Text("No information available")
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 100)
    }
}

extension DealLookupView {
    @ViewBuilder
    func gameDescriptionItem(items: [String], title: String) -> some View {
        if !items.isEmpty {
            VStack(alignment: .leading, spacing: 4) {
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
            VStack(alignment: .leading, spacing: 4) {
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
            VStack(alignment: .leading, spacing: 4) {
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

//
//  DealLookupView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 27/06/23.
//

import SwiftUI

struct DealLookupView: View {
    // MARK: - PROPERTIES
    @StateObject var viewModel = DealLookupViewModel()
    @Environment (\.presentationMode) var presentation
    
    let feedGameDealModel: FeedGameDealModel
    
    @State private var scrollPosition: CGPoint = .zero
    @State private var showNavigationTitle = false
    
    // MARK: - INITIALIZER
    init(feedGameDealModel: FeedGameDealModel) {
        self.feedGameDealModel = feedGameDealModel
//        UIScrollView.appearance().bounces = false
    }
    
    // MARK: - BODY
    var body: some View {
        buildedContent
            .onAppear {
                Task {
                    await viewModel.setupView(feedGameDealModel: self.feedGameDealModel)
                }
            }
            .onBackSwipe {
                presentation.wrappedValue.dismiss()
            }
    }
    
    // MARK: - BACK BUTTON
    @ViewBuilder
    private func makeBackButton() -> some View {
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward.circle.fill")
                .foregroundColor(.gray)
        }
    }
    
    private func showNavigationTitleDescription() -> String {
        if showNavigationBar() {
            return ""
        }
        return viewModel.feedGameDealModel?.title ?? "Unkow"
    }
    
    private func showNavigationBar() -> Bool {
        if self.scrollPosition.y >= -5.0 {
            return true
        }
        return false
    }
}

extension DealLookupView {
    @ViewBuilder
    var buildedContent: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
        case .loaded:
            contentView
        case .error:
            Text("Error")
        }
    }
}

extension DealLookupView {
    @ViewBuilder
    var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                
                gameImage()
                                
                dealDetail()
                
                storesDeals()
                
                gameDetails
            }
            .background(GeometryReader { geometry in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
            })
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.scrollPosition = value
            }
        }
        .fontDesign(.rounded)
        .coordinateSpace(name: "scroll")
        .navigationTitle(showNavigationTitleDescription())
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(showNavigationBar())
        // MARK: - TOOL BAR
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if showNavigationBar() {
                    makeBackButton()
                }
            }
        }
    }
}

extension DealLookupView {
    @ViewBuilder
    var gameDetails: some View {
        VStack(alignment: .leading, spacing: 16) {
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
                    .font(.title3)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(items, id: \.self) { item in
                            Text(item)
                                .font(.body)
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                                .padding(8)
                                .background(Color.gray.opacity(0.08))
                                .clipShape(.rect(cornerRadius: 8))
                        }
                    }
                }
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
                    .font(.title3)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                
                Text(item)
                    .font(.body)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .padding(8)
                    .background(Color.gray.opacity(0.08))
                    .clipShape(.rect(cornerRadius: 8))
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
                    .font(.title3)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                
                Text(description)
                    .font(.body)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.leading)
                    .padding(8)
                    .background(Color.gray.opacity(0.08))
                    .clipShape(.rect(cornerRadius: 4))
            }
        }
    }
}

struct DealLookupView_Previews: PreviewProvider {
    static var previews: some View {
        let view = DealLookupView(feedGameDealModel: FeedGameDealModel.riseOfIndustryMock)
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

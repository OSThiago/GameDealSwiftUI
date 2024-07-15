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
    }
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                makeSectionDeailDetail()
                
                gameDetails
            }
            .onAppear {
                Task {
                    await viewModel.setupView(feedGameDealModel: self.feedGameDealModel)
                }
            }
            .onBackSwipe {
                presentation.wrappedValue.dismiss()
            }
            .background(GeometryReader { geometry in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
            })
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.scrollPosition = value
            }
        }
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
    var gameDetails: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let metacriticModel = viewModel.metacriticDetailModel {
                Text(metacriticModel.description)
                Text("Publisher: \(metacriticModel.publisher)")
                Text("Release Date \(metacriticModel.releaseDate)")
                
                HStack(alignment: .top) {
                    Text("Platforms: ")
                    ForEach(metacriticModel.platforms, id: \.self) { platform in
                        Text(platform)
                            .truncationMode(.head)
                            .lineLimit(4)
                    }
                }
                
                HStack(alignment: .top) {
                    Text("Developers: ")
                    ForEach(metacriticModel.developers, id: \.self) { developer in
                        Text(developer)
                    }
                }
                
                HStack(alignment: .top) {
                    Text("Genres: ")
                    ForEach(metacriticModel.genres, id: \.self) { genre in
                        Text(genre)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct DealLookupView_Previews: PreviewProvider {
    static var previews: some View {
        DealLookupView(feedGameDealModel: FeedGameDealModel.riseOfIndustryMock)
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

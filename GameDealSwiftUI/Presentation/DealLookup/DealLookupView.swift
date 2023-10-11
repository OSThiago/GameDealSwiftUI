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
                
                makeGenres()
                
                makeGameDescription()
                
                makeSimilarGames(title: "Similar names", games: viewModel.searchGamesModel?.results ?? [])
            }
            .onAppear {
                viewModel.setupView(feedGameDealModel: self.feedGameDealModel)
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

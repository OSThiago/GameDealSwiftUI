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
    
    init(feedGameDealModel: FeedGameDealModel) {
        self.feedGameDealModel = feedGameDealModel
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
}

// MARK: - Builded Content
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

// MARK: - Content
extension DealLookupView {
    @ViewBuilder
    var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                
                gameImage
                                
                dealDetailSection
                            
                storesDealsSection
                
                gameDetailsSection
            }
            .background(GeometryReader { geometry in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
            })
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.viewModel.scrollPosition = value
            }
        }
        .coordinateSpace(name: "scroll")
        .navigationTitle(viewModel.showNavigationTitleDescription())
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(viewModel.showNavigationBar())
        // MARK: - TOOL BAR
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if viewModel.showNavigationBar() {
                    backButton()
                }
            }
        }
    }
}

// MARK: - BACK BUTTON
extension DealLookupView {
    @ViewBuilder
    private func backButton() -> some View {
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward.circle.fill")
                .foregroundColor(Color.white)
                .shadow(radius: 2)
        }
    }
}

//struct DealLookupView_Previews: PreviewProvider {
//    static var previews: some View {
//        let view = DealLookupView(feedGameDealModel: FeedGameDealModel.riseOfIndustryMock)
//    }
//}

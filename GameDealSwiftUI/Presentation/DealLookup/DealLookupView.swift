//
//  DealLookupView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 27/06/23.
//

import SwiftUI

struct DealLookupView: View {
    // MARK: - PROPERTIES
    @StateObject var viewModel: DealLookupViewModel
    @EnvironmentObject var router: Router

    let constants = DealLookupConstants()
    
    init(viewModel: DealLookupViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - BODY
    var body: some View {
        buildedContent
            .onAppear {
                Task {
                    await viewModel.viewDidLoad()
                }
            }
            .onBackSwipe {
                router.pop()
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
                
                ZStack(alignment: .bottomTrailing) {
                    gameImage
                    
                    Savings(savings: viewModel.FormatterUseCase.formatSavings(viewModel.feedGameDealModel.savings),
                            font: .body,
                            padding: Tokens.padding.nano)
                    .padding(Tokens.padding.nano)
                }
                
                                
                dealDetailSection
                            
                storesDealsSection
                
                gameDetailsSection
            }
            .background(GeometryReader { geometry in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named(constants.scrollkey)).origin)
            })
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.viewModel.scrollPosition = value
            }
        }
        .coordinateSpace(name: constants.scrollkey)
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

struct DealLookupView_Previews: PreviewProvider {
    static var previews: some View {
        lazy var viewModel: DealLookupViewModel = {
            let viewModel = DealLookupViewModel(feedGameDealModel: .riseOfIndustryMock,
                                                store: .steamMock)
            viewModel.viewState = .loaded
            return viewModel
        }()
        
        DealLookupConfigurator(feedGameDealModel: FeedGameDealModel.riseOfIndustryMock,
                               store: .steamMock).configure()
    }
}

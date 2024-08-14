//
//  FeedView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel: FeedViewModel
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var router: Router
    
    let constants = FeedConstants()
    
    init(viewModel: FeedViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        buildedContent
            .onAppear {
                Task {
                    viewModel.fetchStores()
                    viewModel.displayDealsAAA()
                }
            }
    }
}

// MARK: - Builded Content
extension FeedView {
    @ViewBuilder
    var buildedContent: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
        case .loaded:
            content
        case .error:
            Text(constants.viewErrorMensage)
        }
    }
}

// MARK: - Content
extension FeedView {
    @ViewBuilder
    var content: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    highlightDealSection(deals: viewModel.dealsAAA, title: constants.highlightTitle)
                    
                    storeList(title: constants.storeSectionTitle, stores: viewModel.storesInformations)
                    
                    dealsByStoreSection
                }
            }
            .foregroundStyle(Color(uiColor: colorScheme == .light ? .darkText : .lightText))
            .navigationTitle(constants.navigationTitle)
        }
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}

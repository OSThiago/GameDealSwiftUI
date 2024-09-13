//
//  ListDealsView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 24/06/23.
//

import SwiftUI

struct ListDealsView: View {
    
    @StateObject var viewModel: ListDealViewModel
    @EnvironmentObject var router: Router
    @State var isShowDatail = false
    private let constants = ListDealConstants()
    
    init(
        viewModel: ListDealViewModel
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        buildedContent
        .onAppear {
            viewModel.fetchDeals()
        }
        .navigationTitle(viewModel.store.storeName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                let image = viewModel.formatterUseCase.getStoreImage(store: viewModel.store)
                StoreImage(storeImage: image,
                           size: constants.storeImageSize)
            }
        }
    }
}

// MARK: - Builded content
extension ListDealsView {
    @ViewBuilder
    var buildedContent: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
        case .loaded:
            content
        case .error:
            Text(constants.viewErrorState)
        }
    }
}

// MARK: - Content
extension ListDealsView {
    @ViewBuilder
    var content: some View {
        if !viewModel.dealList.isEmpty {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: Tokens.padding.nano) {
                    ForEach(viewModel.dealList, id: \.dealID) { deal in
                        Button {
                            router.push(.dealDetail(feedGameDealModel: deal))
                        } label: {
                            ListDealCell(title: deal.title,
                                         salePrice: deal.salePrice,
                                         normalPrice: deal.normalPrice,
                                         savings: viewModel.formatterUseCase.formatSavings(deal.savings),
                                         thumb: viewModel.formatterUseCase.getHightQualityImage(url: deal.thumb),
                                         storeThumb: viewModel.formatterUseCase.getStoreImage(store: viewModel.store))
                        }

                        Divider()
                    }
                }
            }
            .padding(.horizontal)
        } else {
            Text(constants.emptyMessage)
        }
    }
}

struct ListDealsView_Previews: PreviewProvider {
    static var previews: some View {
        ListDealsConfigurator(store: StoresCheapShark.steamMock).configure()
    }
}

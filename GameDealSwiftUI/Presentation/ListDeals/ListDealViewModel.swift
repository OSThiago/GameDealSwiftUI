//
//  ListDealViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 25/06/23.
//

import SwiftUI

protocol ListDealsViewModelProtocol {
    var dealsList: [FeedGameDealModel] { get set }
    var viewState: ViewState { get set }
    func fetchDeals() async
}

final class ListDealViewModel: ObservableObject {

    @Injected var dealsService: DealsProtocol
    @Injected var formatterUseCase: FormatterProcol
    
    @Published var dealList = [FeedGameDealModel]()
    @Published var viewState: ViewState = .loading

    let store: StoresCheapShark
    
    init(
        store: StoresCheapShark
    ) {
        self.store = store
    }
    
    @MainActor
    func fetchDeals() async {
        
        let query:[DealsQuery] = [
            .pageNumber(number: 0),
            .pageSize(size: 30),
            .sortBy(option: CheapSharkSortDeals.DEALRATING.rawValue),
            .AAA(isActive: true),
            .storeID(id: store.storeID),
            .metacritic(rating: 50)
        ]
        
        let endpoint: DealsEndPoint = .dealsList(queryItens: query)
        
        do {
            let deals = try await dealsService.dealsList(endPoint: endpoint)

            self.dealList = parse(deals: deals)
            
            withAnimation(.linear) {
                self.viewState = .loaded
            }

        } catch {
            print(error)
            self.viewState = .error
        }
    }
    
    private func parse(deals: [DealModel]) -> [FeedGameDealModel] {
        return deals.map { dealModel in
            FeedGameDealModel(gameID: dealModel.gameID ?? "unknown",
                              dealID: dealModel.dealID ?? "unknown",
                              storeID: dealModel.storeID ?? "unknown",
                              title: dealModel.title ?? "unknown",
                              salePrice: dealModel.salePrice ?? "unknown",
                              normalPrice: dealModel.normalPrice ?? "unknown",
                              savings: dealModel.savings ?? "unknown",
                              thumb: dealModel.thumb ?? "unknown",
                              metacriticLink: dealModel.metacriticLink ?? "unknown")
        }
    }
}

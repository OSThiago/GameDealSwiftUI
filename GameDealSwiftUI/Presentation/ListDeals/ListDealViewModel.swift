//
//  ListDealViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 25/06/23.
//

import SwiftUI

final class ListDealViewModel: ObservableObject {
    
    @Injected var serviceCheapShark: CheapSharkServiceProtocol
    @Injected var formatterUseCase: FormatterProcol
    
    @Published var dealList = [FeedGameDealModel]()
    @Published var viewState: ViewState = .loading

    let store: StoresCheapShark
    
    init(
        store: StoresCheapShark
    ) {
        self.store = store
    }
    
    func fetchDeals() {
        let endpoint = EndpointCasesCheapShark.getDealsList(pageNumber: 0,
                                                            pageSize: 30,
                                                            sortList: .DEALRATING,
                                                            AAA: false,
                                                            storeID: store.storeID)
        
        serviceCheapShark.getDealsList(endpoint: endpoint) { result in
            switch result {
            case .success(let deals):
                DispatchQueue.main.async {
                    self.dealList = deals
                    withAnimation(.linear) {
                        self.viewState = .loaded
                    }
                }
            case .failure(let failure):
                // TODO: - Tratar erro
                print(failure)
                self.viewState = .error
            }
        }
    }
    
    @MainActor
    func fetchDealsTest() async {
        
        let service: DealsProtocol = DealsServiceImpelentation()
        
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
            let deals = try await service.dealsList(endPoint: endpoint)
            
            let result = deals.map { dealModel in
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
            
            self.dealList = result
            
            withAnimation(.linear) {
                self.viewState = .loaded
            }

        } catch {
            print(error)
            self.viewState = .error
        }
    }
}

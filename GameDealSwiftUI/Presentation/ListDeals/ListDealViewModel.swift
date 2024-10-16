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
}

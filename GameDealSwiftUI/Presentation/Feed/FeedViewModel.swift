//
//  FeedViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

final class FeedViewModel: ObservableObject {
    
    @Injected var serviceCheapShark: CheapSharkServiceProtocol
    @Injected var formatterUseCase: FormatterProcol
    
    // Data
    @Published var dealsAAA = [FeedGameDealModel]()
    @Published var storesDeals: [(store: StoresCheapShark, dealsList:[FeedGameDealModel])] = []
    @Published var storesInformations = [StoresCheapShark]()
    // States
    @Published var viewState: ViewState = .loading
    @Published var isLoadedAAAGames = false
    @Published var isLoadedStoreGames = false

    func viewDidLoad() {
        fetchStores()
        displayDealsAAA()
    }
    
    // Funcs
    private func fetchStores() {
        if !storesInformations.isEmpty {
            return
        }
        
        serviceCheapShark.getStores { result in
            switch result {
            case .success(let stores):
                DispatchQueue.main.async {
                    self.storesInformations = stores
                    self.displayDealsStores()
                }
            case .failure(let failure):
                // TODO: - Tratar erro
                print(" erro ao baixar store image - \(failure)")
            }
        }
    }
    
    private func displayDealsAAA() {
        
        if !dealsAAA.isEmpty {
            return
        }
        
        let endpoint = EndpointCasesCheapShark.getDealsList(pageNumber: 0,
                                                            pageSize: 8,
                                                            sortList: .DEALRATING,
                                                            AAA: true,
                                                            storeID: nil)
        
        serviceCheapShark.getDealsList(endpoint: endpoint) { result in
            switch result {
            case .success(let deals):
                DispatchQueue.main.async { [weak self] in
                    
                    var filtered = [FeedGameDealModel]()
                    
                    for deal in deals {
                        if !filtered.contains(where: { $0.title == deal.title }) {
                            filtered.append(deal)
                        }
                    }
                    
                    self?.dealsAAA = filtered
                    self?.isLoadedAAAGames = true
                    self?.checkIsLoadedInfos()
                }
            case .failure(let failure):
                // TODO: - Tratar erro
                print(failure)
            }
        }
    }
    
    private func displayDealsStores() {
        let selectedStores = ["Steam", "Epic Games Store", "GreenManGaming" , "GOG"]
        
        if !storesDeals.isEmpty {
            return
        }
        
        for selectedStore in selectedStores {
            
            guard let store = storesInformations.first(where: {$0.storeName == selectedStore}) else { return }
            
            let endpoint = EndpointCasesCheapShark.getDealsList(pageNumber: 0, pageSize: 10, sortList: .DEALRATING, AAA: false, storeID: store.storeID)
            
            serviceCheapShark.getDealsList(endpoint: endpoint) { result in
                switch result {
                case .success(let deals):
                    DispatchQueue.main.async {
                        self.storesDeals.append((store: store, dealsList: deals))
                        self.isLoadedStoreGames = true
                        self.checkIsLoadedInfos()
                    }
                case .failure(let failure):
                    // TODO: - Tratar erro
                    print(failure)
                }
            }
        }
    }
    
    func setupDealCell(_ model: FeedGameDealModel) -> FeedGameDealModel {
        let model = FeedGameDealModel(
            gameID: model.gameID,
            dealID: model.dealID,
            storeID: storeImage(storeID: model.storeID),
            title: model.title,
            salePrice: "$\(model.salePrice)",
            normalPrice: "$\(model.normalPrice)",
            savings: formatterUseCase.formatSavings(model.savings),
            thumb: formatterUseCase.getHightQualityImage(url: model.thumb),
            metacriticLink: model.metacriticLink
        )
        return model
    }
    
    private func checkIsLoadedInfos() {
        if isLoadedAAAGames == true  && isLoadedStoreGames == true {
            withAnimation(.easeIn) {
                self.viewState = .loaded
            }
        }
    }
    
    func storeName(storeID: String) -> String {
        guard let store = self.storesInformations.first(where: {$0.storeID == storeID}) else { return ""}
        return store.storeName
    }
    
    func storeImage(storeID: String) -> String {
        guard let store = self.storesInformations.first(where: { $0.storeID == storeID }) else { return "" }
        return formatterUseCase.getStoreImage(store: store)
    }
}

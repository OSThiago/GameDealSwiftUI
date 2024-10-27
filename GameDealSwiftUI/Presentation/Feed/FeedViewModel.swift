//
//  FeedViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

final class FeedViewModel: ObservableObject {

    @Injected var storesUseCase: StoresProtocol
    @Injected var dealsUseCase: DealsProtocol
    @Injected var formatterUseCase: FormatterProcol
    
    // Data
    @Published var dealsAAA = [FeedGameDealModel]()
    @Published var storesDeals: [(store: StoresCheapShark, dealsList:[FeedGameDealModel])] = []
    @Published var storesInformations = [StoresCheapShark]()
    // States
    @Published var viewState: ViewState = .loading
    @Published var isLoadedAAAGames = false
    @Published var isLoadedStoreGames = false

    func viewDidLoad() async {
        await fetchStores()
        await displayDealsAAA()
        await displayDealsStores()
    }
    
    // MARK: - Stores
    private func fetchStores() async {
        do {
            let stores = try await storesUseCase.storesInformation(endpoint: .storesInformation)
            
            let activeStores = stores.filter { $0.isActive == 1 }
            
            DispatchQueue.main.async {
                self.storesInformations = activeStores
            }
        } catch {
            // TODO: - Tratar erro
            print(" erro ao baixar store image - \(error)")
        }
    }
    
    // MARK: - Best Deals
    private func displayDealsAAA() async {
        
        if !dealsAAA.isEmpty {
            return
        }
        
        let endpoint = DealsEndPoint.dealsList(queryItens: [
            .pageNumber(number: 0),
            .pageSize(size: 8),
            .sortBy(option: CheapSharkSortDeals.DEALRATING.rawValue),
            .AAA(isActive: true),
        ])

        do {
            let deals = try await dealsUseCase.dealsList(endPoint: endpoint)
            
            let filtered = await unrepeatedFilter(deals: deals)
            
            DispatchQueue.main.async {
                self.dealsAAA = self.parseDealsModel(deals: filtered).uniqued()
                self.isLoadedAAAGames = true
                self.checkIsLoadedInfos()
            }
            
        } catch {
            // TODO: - Tratar erro
            print(error)
        }
    }
    
    func unrepeatedFilter(deals: [DealModel]) async -> [DealModel] {
        var unrepeatedFilter = [DealModel]()
        
        for deal in deals {
            if !unrepeatedFilter.contains(where: { $0.title == deal.title }) {
                unrepeatedFilter.append(deal)
            }
        }
        return unrepeatedFilter
    }
    
    private func parseDealsModel(deals: [DealModel]) -> [FeedGameDealModel] {
        return deals.compactMap { deal in
            FeedGameDealModel(gameID: deal.gameID ?? "",
                              dealID: deal.dealID ?? "",
                              storeID: deal.storeID ?? "",
                              title: deal.title ?? "",
                              salePrice: deal.salePrice ?? "",
                              normalPrice: deal.normalPrice ?? "",
                              savings: deal.savings ?? "",
                              thumb: deal.thumb ?? "",
                              metacriticLink: deal.metacriticLink ?? "")
        }
    }
    
    
    // MARK: - Deals by stores
    private func displayDealsStores() async {
        let selectedStores = ["Steam", "Epic Games Store", "GreenManGaming" , "GOG"]
        
        if !storesDeals.isEmpty {
            return
        }
        
        for selectedStore in selectedStores {
            
            guard let store = storesInformations.first(where: {$0.storeName == selectedStore}) else { return }
            
            let endpoint = DealsEndPoint.dealsList(queryItens: [
                .pageNumber(number: 0),
                .pageSize(size: 10),
                .sortBy(option: CheapSharkSortDeals.DEALRATING.rawValue),
                .AAA(isActive: false),
                .storeID(id: store.storeID)
            ])
            
            do {
                let deals = try await dealsUseCase.dealsList(endPoint: endpoint)
                DispatchQueue.main.async {
                    self.storesDeals.append((store: store, dealsList: self.parseDealsModel(deals: deals)))
                }
            } catch {
                print(error)
            }
        }
        DispatchQueue.main.async {
            self.isLoadedStoreGames = true
            self.checkIsLoadedInfos()
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
                DispatchQueue.main.async {
                    self.viewState = .loaded
                }
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
    
    func getStore(storeID: String) -> StoresCheapShark? {
        return self.storesInformations.first(where: {$0.storeID == storeID})
    }
}

//
//  DealLookupViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 27/06/23.
//

import SwiftUI

final class DealLookupViewModel: ObservableObject, FormatterDealData {
    
    var storesInformations: [StoresCheapShark] = []
    
    let workerCheapShark = WorkerCheapShark()
    let workerMetacritic = MetacriticWebScrapingImplementation()
    
    // To fetch when get gameID
    @Published var gameLookupModel: GameLookupModel?
    
    // To recive from feed
    @Published var feedGameDealModel: FeedGameDealModel?
    @Published var metacriticDetailModel: MetacriticDetailModel?
    @Published var viewState: ViewState = .loading
    
    @MainActor
    func setupView(feedGameDealModel: FeedGameDealModel) async {
        self.feedGameDealModel = feedGameDealModel
        fetchStoresInformations()
        fetchDealLookup(gameID: feedGameDealModel.gameID)
        self.metacriticDetailModel = await fetchMetacriticDetailsInformation(metacriticLink: feedGameDealModel.metacriticLink ?? "")
    }
    
    func fetchDealLookup(gameID: String) {
        
        let endpoint = EndpointCasesCheapShark.getGameLookup(gameID)
        
        workerCheapShark.getGameLookup(endpoint: endpoint) { result in
            switch result {
            case .success(let gameData):
                DispatchQueue.main.async {
                    self.gameLookupModel = gameData
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchStoresInformations() {
        if !storesInformations.isEmpty {
            return
        }
        
        workerCheapShark.getStores { result in
            switch result {
            case .success(let stores):
                DispatchQueue.main.async {
                    self.storesInformations = stores
                }
            case .failure(let failure):
                // TODO: - Tratar erro
                print(" erro ao baixar store image - \(failure)")
            }
        }
    }
    
    func formatSavings(_ savings: String) -> String {
        var savingFormatted = ""
        
        let index = savings.firstIndex(of: ".") ?? savings.endIndex
        
        let beginning = savings[..<index]
        
        savingFormatted = String(beginning)
        
        return "-\(savingFormatted)%"
    }
    
    // MARK: - Metacritic
    @MainActor
    func fetchMetacriticDetailsInformation(metacriticLink: String) async -> MetacriticDetailModel{
        let baseURL = "https://www.metacritic.com"
        let details = "details/"
        let url = baseURL + metacriticLink + details
        
        let htmlContent = await workerMetacritic.getURLContent(url: url)
        
        let description = getMetacriticDescription(htmlContent: htmlContent)
        let releaseDate = getReleaseDate(htmlContent: htmlContent)
        let publisher = getPublisher(htmlContent: htmlContent)
        let platforms = getPlatforms(htmlContent: htmlContent)
        let developers = getDevelopers(htmlContent: htmlContent)
        let genres = getGenres(htmlContent: htmlContent)

        self.viewState = .loaded
        return MetacriticDetailModel(description: description,
                                     releaseDate: releaseDate,
                                     publisher: publisher,
                                     platforms: platforms,
                                     developers: developers,
                                     genres: genres)
    }

    private func getMetacriticDescription(htmlContent: String) -> String {
        let className = "c-pageProductDetails_description"
        return workerMetacritic.getContent(htmlContent: htmlContent, byClass: className)
    }
    
    private func getReleaseDate(htmlContent: String) -> String {
        let className = "c-gameDetails_ReleaseDate"
        let release = workerMetacritic.getContent(htmlContent: htmlContent, byClass: className)
        return release.replacingOccurrences(of: "Initial Release Date: ", with: "")
    }
    
    private func getPublisher(htmlContent: String) -> String {
        let className = "c-gameDetails_Distributor"
        let publisher = workerMetacritic.getContent(htmlContent: htmlContent, byClass: className)
        return publisher.replacingOccurrences(of: "Publisher: ", with: "")
    }
    
    private func getPlatforms(htmlContent: String) -> [String] {
        let className = "c-gameDetails_Platforms"
        let tag = "li"
        
        let classContent = workerMetacritic.filterRawHtmlContent(fullHtmlContent: htmlContent, byClass: className)
        return workerMetacritic.getContents(htmlContent: classContent, byElementsTag: tag)
    }
    
    private func getDevelopers(htmlContent: String) -> [String] {
        let className = "c-gameDetails_Developer"
        let tag = "li"
        
        let classContent = workerMetacritic.filterRawHtmlContent(fullHtmlContent: htmlContent, byClass: className)
        return workerMetacritic.getContents(htmlContent: classContent, byElementsTag: tag)
    }
    
    private func getGenres(htmlContent: String) -> [String] {
        let className = "c-genreList"
        let tag = "span"
        
        let classContent = workerMetacritic.filterRawHtmlContent(fullHtmlContent: htmlContent, byClass: className)
        return workerMetacritic.getContents(htmlContent: classContent, byElementsTag: tag)
    }
}

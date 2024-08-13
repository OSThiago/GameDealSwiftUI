//
//  MetacriticWebScrapingImplementaiton.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 09/07/24.
//

import Foundation
import SwiftSoup
import WebKit

class MetacriticServiceImplementation: MetacriticServiceProtocol {
    
    private let webScrapingUseCase: WebScrapingUseCaseProtocol
    
    init() {
        self.webScrapingUseCase = WebScrapingUseCaseImplementation()
    }
    
    func fetchDetailsInformation(metacriticLink: String) async -> MetacriticDetailModel {
        let details = "details/"
        let url = metacriticLink + details
        
        let htmlContent = await webScrapingUseCase.getURLContent(url: url)
        
        let description = getMetacriticDescription(htmlContent: htmlContent)
        let releaseDate = getReleaseDate(htmlContent: htmlContent)
        let publisher = getPublisher(htmlContent: htmlContent)
        let platforms = getPlatforms(htmlContent: htmlContent)
        let developers = getDevelopers(htmlContent: htmlContent)
        let genres = getGenres(htmlContent: htmlContent)

        return MetacriticDetailModel(description: description,
                                     releaseDate: releaseDate,
                                     publisher: publisher,
                                     platforms: platforms,
                                     developers: developers,
                                     genres: genres)
    }
}

extension MetacriticServiceImplementation {
    private func getMetacriticDescription(htmlContent: String) -> String {
        let className = "c-pageProductDetails_description"
        return webScrapingUseCase.getContent(htmlContent: htmlContent, byClass: className)
    }
    
    private func getReleaseDate(htmlContent: String) -> String {
        let className = "c-gameDetails_ReleaseDate"
        let release = webScrapingUseCase.getContent(htmlContent: htmlContent, byClass: className)
        return release.replacingOccurrences(of: "Initial Release Date: ", with: "")
    }
    
    private func getPublisher(htmlContent: String) -> String {
        let className = "c-gameDetails_Distributor"
        let publisher = webScrapingUseCase.getContent(htmlContent: htmlContent, byClass: className)
        return publisher.replacingOccurrences(of: "Publisher: ", with: "")
    }
    
    private func getPlatforms(htmlContent: String) -> [String] {
        let className = "c-gameDetails_Platforms"
        let tag = "li"
        
        let classContent = webScrapingUseCase.filterRawHtmlContent(fullHtmlContent: htmlContent, byClass: className)
        return webScrapingUseCase.getContents(htmlContent: classContent, byElementsTag: tag)
    }
    
    private func getDevelopers(htmlContent: String) -> [String] {
        let className = "c-gameDetails_Developer"
        let tag = "li"
        
        let classContent = webScrapingUseCase.filterRawHtmlContent(fullHtmlContent: htmlContent, byClass: className)
        return webScrapingUseCase.getContents(htmlContent: classContent, byElementsTag: tag)
    }
    
    private func getGenres(htmlContent: String) -> [String] {
        let className = "c-genreList"
        let tag = "span"
        
        let classContent = webScrapingUseCase.filterRawHtmlContent(fullHtmlContent: htmlContent, byClass: className)
        return webScrapingUseCase.getContents(htmlContent: classContent, byElementsTag: tag)
    }
}

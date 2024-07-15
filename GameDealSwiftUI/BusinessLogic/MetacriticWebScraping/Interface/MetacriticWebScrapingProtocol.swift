//
//  MetacriticWebScrapingProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/07/24.
//

import Foundation

protocol MetacriticWebScrapingProtocol {
    func getContent(htmlContent: String, byClass className: String) -> String
    func filterRawHtmlContent(fullHtmlContent: String, byClass className: String) -> String
    func getContents(htmlContent: String, byElementsTag tag: String) -> [String]
    func getURLContent(url: String) async -> String
}

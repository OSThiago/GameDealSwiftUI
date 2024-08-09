//
//  ScrapingUseCase.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 08/08/24.
//

import Foundation
import SwiftSoup

struct WebScrapingUseCaseImplementation: WebScrapingUseCaseProtocol {
    func getContent(htmlContent: String, byClass className: String) -> String {
        do {
            let document: Document = try SwiftSoup.parse(htmlContent)
            
            guard let body = document.body() else { return ""}

            let contents = try body.getElementsByClass(className).first()
            
            let formatted = try contents?.text() ?? ""

            return formatted
        } catch {
            print("Error Parsing: " + String(describing: error))
            return "content error"
        }
    }
    
    func filterRawHtmlContent(fullHtmlContent: String, byClass className: String) -> String {
        do {
            let document: Document = try SwiftSoup.parse(fullHtmlContent)
            
            guard let body = document.body() else { return "" }
            
            guard let content = try body.getElementsByClass(className).first() else { return "" }
            
            return content.description
        } catch {
            print("Error Parsing: " + String(describing: error))
            return "filter error"
        }
    }
    
    func getContents(htmlContent: String, byElementsTag tag: String) -> [String] {
        do {
            let document: Document = try SwiftSoup.parse(htmlContent)
            guard let body = document.body() else { return [] }
            let contents = try body.getElementsByTag(tag)
            
            var platforms = [String]()
            for content in contents {
                platforms.append(try content.text())
            }
            
            return platforms
        } catch {
            print("Error Parsing: " + String(describing: error))
            return []
        }
    }
    
    func getURLContent(url: String) async -> String {
        guard let url = URL(string: url) else {
            print("Error: \(url) doesn't seem to be a valid URL")
            return "error"
        }
        do {
            let htmlString = try String(contentsOf: url, encoding: .utf8)
            return htmlString
        } catch let error {
            print("Error: \(error)")
            return "error"
        }
    }
}

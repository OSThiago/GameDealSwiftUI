//
//  SearchConstants.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 06/11/24.
//

import Foundation

struct SearchConstants {
    // - Navigation
    let navigationTitle = "Search"
    
    // - Search bar
    let searchbarPlaceholder = "Search games"
    
    // - Empty State
    let emptyTitle = "Search for Games"
    let emptyDescription = "try searching for game name"
    let emptyResultTitle = "No Results"
    func emptyResultDescription(text: String) -> String {
        "No results for '\(text)'"
    }
    
    // Game Image
    let imageWidth: CGFloat = 60 * 16/9
    let imageHeight: CGFloat = 60
    let imagePlaceholder = "photo.artframe"
}

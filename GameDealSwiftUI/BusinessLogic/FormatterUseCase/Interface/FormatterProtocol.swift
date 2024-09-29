//
//  FormatterProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/08/24.
//

import Foundation

protocol FormatterProcol {
    func getHightQualityImage(url: String) -> String
    func getStoreImage(store: StoresCheapShark) -> String
    func formatSavings(_ savings: String) -> String
}

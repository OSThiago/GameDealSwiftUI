//
//  MetacriticWebScrapingProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/07/24.
//

import Foundation

protocol MetacriticServiceProtocol {
    func fetchDetailsInformation(metacriticLink: String) async -> MetacriticDetailModel
}

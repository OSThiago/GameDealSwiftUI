//
//  CheapSharkServiceProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 16/08/24.
//

import Foundation

protocol CheapSharkServiceProtocol {
    func getDealsList(endpoint: Endpoint, completion: @escaping (Result<[FeedGameDealModel] ,ServiceError>) -> ())
    func getGameLookup(endpoint: Endpoint, completion: @escaping (Result<GameLookupModel, ServiceError>) -> ())
    func getStores(completion: @escaping (Result<[StoresCheapShark], ServiceError>) -> ())
}

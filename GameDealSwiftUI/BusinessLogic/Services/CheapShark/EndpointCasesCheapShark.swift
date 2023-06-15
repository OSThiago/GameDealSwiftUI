//
//  EndpointCasesCheapShark.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import Foundation

enum EndpointCasesCheapShark: Endpoint {
    
    case getDealsList(pageNumber: Int, pageSize: Int, sortList: CheapSharkSortDeals, AAA: Bool, storeID: String?)
    case getDealLookup(_ dealID: String)
    case getGameLookup(_ gameID: String)
    case getStores
    
    var baseURLString: String {
        return BaseURL.cheapsharkURL
    }
    
    var httpMethod: String {
        switch self {
            
        case .getDealsList(pageNumber: _, pageSize: _, sortList: _, AAA: _, storeID: _):
            return "GET"
        case .getDealLookup(_):
            return "GET"
        case .getGameLookup(_):
            return "GET"
        case .getStores:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .getDealsList(pageNumber: _, pageSize: _, sortList: _, AAA: _, storeID: _):
            return "/api/1.0/deals?"
        case .getDealLookup(_):
            return "/api/1.0/deals?"
        case .getGameLookup(_):
            return "/api/1.0/deals?"
        case .getStores:
            return "/api/1.0/stores"
        }
    }
    
    var query: String? {
        switch self {
        case .getDealsList(pageNumber: let pageNumber, pageSize: let pageSize, sortList: let sortList, AAA: let AAA, storeID: let storeID):
            
            var isAAA = 0
            
            if AAA {
                isAAA = 1
            }
            
            if let storeID = storeID {
                return "storeID=\(storeID)&pageNumber=\(pageNumber)&pageSize=\(pageSize)&sortList=\(sortList)&AAA\(isAAA)"
            }
            
            return "pageNumber=\(pageNumber)&pageSize=\(pageSize)&sortList=\(sortList)&AAA\(isAAA)"
            
        case .getDealLookup(dealID: let dealID):
            return "id=\(dealID)"
            
        case .getGameLookup(gameID: let gameID):
            return "id=\(gameID)"
            
        case .getStores:
            return nil
        }
    }
    
    var key: String? {
        return nil
    }
}

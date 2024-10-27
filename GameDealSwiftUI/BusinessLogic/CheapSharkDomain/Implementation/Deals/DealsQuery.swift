//
//  DealsQuery.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/09/24.
//
import Foundation

enum DealsQuery {
    /// (optional, string)
    /// Comma separated list of store ID's to filter on. If not set, all stores will be shown.
    case storeID(id: String)
    
    /// (optional, integer) Default 0
    /// The requested page number, value is 0 indexed.
    case pageNumber(number: Int)
    
    /// (optional, integer) Default 60
    /// The number of deals per page, max value of 60
    case pageSize(size: Int)
    
    /// (optional, string) Default DealRating
    /// Criteria to sort the list by, possible values:
    /// DealRating, Title, Savings, Price, Metacritic, Reviews, Release, Store, Recent
    case sortBy(option: String)
    
    /// (optional, boolean) Default 0
    /// Determines sort direction
    case desc(isActive: Bool)
    
    /// (optional, integer) Default 0
    /// Only returns deals with a price greater than this value
    case lowerPrice(price: Int)
    
    /// (optional, integer)
    /// Only returns deals with a price less than or equal to this value (50 acts the same as no limit)
    case upperPrice(price: Int)
    
    /// (optional, integer)
    /// Minimum Metacritic rating for a game
    case metacritic(rating: Int)
    
    /// (optional, integer)
    /// Minimum Steam reviews rating for a game
    case steamRating(rating: Int)
    
    /// (optional, string)
    /// Look for deals on specific games, comma separated list of Steam App ID (still bound by pageSize)
    case steamAppID(id: String)
    
    /// (optional, string)
    /// Looks for the string contained anywhere in the game name
    case title(title: String)
    
    /// (optional, boolean) Default 0
    /// Flag to allow only exact string match for title parameter
    case exact(isActive: Bool)
    
    /// (optional, boolean) Default 0
    /// Flag to include only deals with retail price > $29
    case AAA(isActive: Bool)
    
    /// (optional, boolean) Default 0
    /// Flag to include only deals that redeem on Steam (best guess, depends on store support)
    case steamWorks(isActive: Bool)
    
    /// (optional, boolean) Default 0
    /// Flag to include only games that are currently on sale
    case onSale(isActive: Bool)
    
    /// (optional, string)
    /// Option to output deals in RSS format (overrides page number/size to 0/100)
    case output(rss: String)
}

extension DealsQuery {
    var queryItem: URLQueryItem {
        switch self {
        case .storeID(let id):
            URLQueryItem(name: "storeID",
                         value: id)
        case .pageNumber(number: let number):
            URLQueryItem(name: "pageNumber",
                         value: number.description)
        case .pageSize(size: let size):
            URLQueryItem(name: "pageSize",
                         value: size.description)
        case .sortBy(option: let option):
            URLQueryItem(name: "sortBy",
                         value: option)
        case .desc(isActive: let isActive):
            URLQueryItem(name: "desc",
                         value: isActive.stringValue)
        case .lowerPrice(price: let price):
            URLQueryItem(name: "lowerPrice",
                         value: price.description)
        case .upperPrice(price: let price):
            URLQueryItem(name: "upperPrice",
                         value: price.description)
        case .metacritic(rating: let rating):
            URLQueryItem(name: "metacritic",
                         value: rating.description)
        case .steamRating(rating: let rating):
            URLQueryItem(name: "steamRating",
                         value: rating.description)
        case .steamAppID(id: let id):
            URLQueryItem(name: "steamAppID",
                         value: id)
        case .title(title: let title):
            URLQueryItem(name: "title",
                         value: title)
        case .exact(isActive: let isActive):
            URLQueryItem(name: "exact",
                         value: isActive.stringValue)
        case .AAA(isActive: let isActive):
            URLQueryItem(name: "AAA",
                         value: isActive.stringValue)
        case .steamWorks(isActive: let isActive):
            URLQueryItem(name: "steamworks",
                         value: isActive.stringValue)
        case .onSale(isActive: let isActive):
            URLQueryItem(name: "onSale",
                         value: isActive.stringValue)
        case .output(rss: let rss):
            URLQueryItem(name: "output",
                         value: rss)
        }
    }
}

extension Bool {
    var stringValue: String {
        if self == true {
            return "1"
        } else {
            return "0"
        }
    }
}

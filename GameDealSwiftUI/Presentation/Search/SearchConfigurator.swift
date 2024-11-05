//
//  SearchConfigurator.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 04/11/24.
//

import Foundation

final class SearchConfigurator {
    
    lazy var viewModel: SearchViewModel = {
        return SearchViewModel()
    }()
    
    init(){}
    
    func configure() -> SearchView {
        return .init(viewModel: viewModel)
    }
}

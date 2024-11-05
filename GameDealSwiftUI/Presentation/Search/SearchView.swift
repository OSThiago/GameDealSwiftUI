//
//  SearchView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 04/11/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SearchConfigurator().configure()
}

//
//  ContentView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage(UserDefaultKeys.theme.rawValue) private var theme: Bool = false
    
    var body: some View {
//        RouterView()
        TabBarView()
            .preferredColorScheme(theme ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

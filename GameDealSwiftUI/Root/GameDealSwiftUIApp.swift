//
//  GameDealSwiftUIApp.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import SwiftUI

@main
struct GameDealSwiftUIApp: App {
    
    private let assembler: Assembler = AppAssembler()
    
    init() {
        assembler.injectionRules()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

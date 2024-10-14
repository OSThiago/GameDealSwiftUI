//
//  AppAssembler.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 16/08/24.
//

import Foundation

protocol Assembler {
    func injectionRules()
}

struct AppAssembler: Assembler {
    func injectionRules() {
        DependencyInjectionContainer.register(type: WebScrapingUseCaseProtocol.self,
                                              WebScrapingUseCaseImplementation())
        
        DependencyInjectionContainer.register(type: MetacriticServiceProtocol.self,
                                              MetacriticServiceImplementation())
        
        DependencyInjectionContainer.register(type: CheapSharkServiceProtocol.self,
                                              CheapSharkServiceImplementation())
        
        DependencyInjectionContainer.register(type: FormatterProcol.self,
                                              FormatterUseCaseImplementation())
        
        DependencyInjectionContainer.register(type: ServiceProtocol.self,
                                              ServiceImplementation())
        
        DependencyInjectionContainer.register(type: DealsProtocol.self,
                                              DealsServiceImpelentation())
        
        DependencyInjectionContainer.register(type: GamesProtocol.self,
                                              GamesServiceImplementation())
        
        DependencyInjectionContainer.register(type: StoresProtocol.self,
                                              StoresImplementation())
    }
}

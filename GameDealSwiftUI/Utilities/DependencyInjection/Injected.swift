//
//  Injected.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 16/08/24.
//

import Foundation

@propertyWrapper
struct Injected<Injected> {
    
    var service: Injected
    
    init(_ dependencyType: InjectionType = .newInstance) {
        guard let dependency = DependencyInjectionContainer.resolve(dependencyType: dependencyType, Injected.self) else {
            fatalError("No dependency of type \(String(describing: Injected.self)) registered!")
        }
        
        self.service = dependency
    }
    
    var wrappedValue: Injected {
        get { self.service }
        mutating set { service = newValue }
    }
}

enum InjectionType {
    case singleton
    case newInstance
    case automatic
}

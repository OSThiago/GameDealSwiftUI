//
//  DependencyInjectionContainer.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 16/08/24.
//

import Foundation

final class DependencyInjectionContainer {
    
    private static var cache: [String: Any] = [:]
    private static var generators: [String: () -> Any] = [:]
    
    static func register<dependency>(type: dependency.Type, as serviceType: InjectionType = .automatic, _ factory: @autoclosure @escaping () -> dependency) {
        generators[String(describing: type.self)] = factory
        
        if serviceType == .singleton {
            cache[String(describing: type.self)] = factory()
        }
    }
    
    static func resolve<dependency>(dependencyType: InjectionType = .automatic, _ type: dependency.Type) -> dependency? {
        let key = String(describing: type.self)
        switch dependencyType {
        case .singleton:
            if let cachedService = cache[key] as? dependency {
                return cachedService
            } else {
                fatalError("\(String(describing: type.self)) is not registeres as singleton")
            }
            
        case .automatic:
            if let cachedService = cache[key] as? dependency {
                return cachedService
            }
            fallthrough
            
        case .newInstance:
            if let service = generators[key]?() as? dependency {
                cache[String(describing: type.self)] = service
                return service
            } else {
                return nil
            }
        }
    }
}

//
//  StoresImplementation.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 14/10/24.
//

struct StoresImplementation: StoresProtocol {
    
    @Injected private var serviceUseCase: ServiceProtocol
    
    func storesInformation(endpoint: StoresEndpoint) async throws -> [StoresCheapShark] {
        return try await serviceUseCase.fetch(endpoint: endpoint)
    }
}

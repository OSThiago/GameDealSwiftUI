//
//  StoresProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/09/24.
//

import Foundation

protocol StoresProtocol {
    func storesInformation(endpoint: StoresEndpoint) async throws -> [StoresCheapShark]
}

//
//  RedirectServiceImplementation.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 06/01/25.
//

import Foundation

struct RedirectServiceImplementation: RedirectProtocol {
    func getDealWebLink(endpoint: RedirectEndpoint) -> String {
        return endpoint.getUrl()
    }
}

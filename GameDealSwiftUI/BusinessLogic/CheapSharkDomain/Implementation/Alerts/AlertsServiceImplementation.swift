//
//  AlertsServiceImplementation.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 04/02/25.
//

import Foundation

struct AlertsServiceImplementation: AlertsProtocol {

    @Injected private var service: ServiceProtocol

    func setAlert(email: String, gameID: Int, price: Double) async throws -> Bool {
        let endpoint = AlertsEndPoint.set(email: email, gameID: gameID, price: price)
        do {
            let status = try await service.set(endpoint: endpoint)
            if status == "true" {
                return true
            }
            return false
        } catch {
            throw error
        }
    }

    func removeAlert(email: String, gameID: Int) async throws -> Bool {
        let endpoint = AlertsEndPoint.remove(email: email, gameID: gameID)
        do {
            let status = try await service.set(endpoint: endpoint)
            if status == "true" {
                return true
            }
            return false
        } catch {
            throw error
        }
    }
}

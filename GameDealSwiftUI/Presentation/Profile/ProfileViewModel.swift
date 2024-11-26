//
//  ProfileViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import Foundation
import LocalAuthentication

final class ProfileViewModel: ObservableObject {
    
    @Published var noteLocked: Bool = true
    @Published var showUnlockModal: Bool = false
    
    func tryBiometricAuthentication() {
        // 1
        let context = LAContext()
        var error: NSError?
        
        // 2
        if context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error) {
            // 3
            let reason = "Authenticate to unlock your note."
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason) { authenticated, error in
                    // 4
                    DispatchQueue.main.async {
                        if authenticated {
                            // 5
                            self.noteLocked = false
                        } else {
                            // 6
                            if let errorString = error?.localizedDescription {
                                print("Error in biometric policy evaluation: \(errorString)")
                            }
                            self.showUnlockModal = true
                        }
                    }
                }
        } else {
            // 7
            if let errorString = error?.localizedDescription {
                print("Error in biometric policy evaluation: \(errorString)")
            }
            showUnlockModal = true
        }
    }
}

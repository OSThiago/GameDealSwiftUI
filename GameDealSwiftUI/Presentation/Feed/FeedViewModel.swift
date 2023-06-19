//
//  FeedViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    // Published Properties
    @Published var dealsAAA = [FeedGameDealModel]()
    
    private let workerCheapShark = WorkerCheapShark()
    
    // Funcs
    func displayDeaslAAA() {
        let endpoint = EndpointCasesCheapShark.getDealsList(pageNumber: 0, pageSize: 10, sortList: .RECENT, AAA: true, storeID: nil)
        
        workerCheapShark.getDealsList(endpoint: endpoint) { result in
            switch result {
            case .success(let deals):
                DispatchQueue.main.async { [self] in
                    self.dealsAAA = deals
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

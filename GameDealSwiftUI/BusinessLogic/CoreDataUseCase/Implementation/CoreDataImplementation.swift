//
//  CoreDataImplementation.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import CoreData
import Foundation

class CoreDataImplementation {
    
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.container.viewContext
    }
    
}
